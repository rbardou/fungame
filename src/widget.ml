let iter x f = List.iter f x
let exists x f = List.exists f x
let fold a x f = List.fold_left f a x

type handler_result =
  | Capture
  | Ignore

type key_down_event =
  {
    key: Key.t;
    shift: bool;
    ctrl: bool;
    alt: bool;
    repeat: bool;
  }

type key_up_event =
  {
    key: Key.t;
    shift: bool;
    ctrl: bool;
    alt: bool;
  }

type mouse_button_event =
  {
    button: Mouse_button.t;
    x: int;
    y: int;
  }

type mouse_move_event =
  {
    x: int;
    y: int;
  }

type available_space =
  {
    available_w: int option;
    available_h: int option;
  }

type layout =
  {
    w: int;
    h: int;
    children: child list;
  }

and laid_out = t

and child =
  {
    x: int;
    y: int;
    child: laid_out;
  }

and parent =
  | Invisible
  | Window of window
  | Widget of t

and t =
  {
    id: int;
    mutable widget_w: int;
    mutable widget_h: int;
    mutable parent: parent;
    mutable widget_children: child list;
    lay_out: available_space -> layout;
    mutable draw: x: int -> y: int -> w: int -> h: int -> unit;
    mutable on_key_down: (key_down_event -> handler_result) list;
    mutable on_key_up: (key_up_event -> handler_result) list;
    mutable on_mouse_down: (mouse_button_event -> handler_result) list;
    mutable on_mouse_up: (mouse_button_event -> handler_result) list;
    mutable on_mouse_move: (mouse_move_event -> handler_result) list;
    mutable on_mouse_wheel: (mouse_move_event -> handler_result) list;
  }

and window =
  {
    mutable root: t option;
    mutable keyboard_focus: t option;
    mutable mouse_capture: t option;
    (* TODO: reset cursor_position to None if mouse leaves the window. *)
    mutable cursor_position: (int * int) option;
    mutable lshift: bool;
    mutable rshift: bool;
    mutable lctrl: bool;
    mutable rctrl: bool;
    mutable lalt: bool;
    mutable ralt: bool;
  }

let create_window () =
  {
    root = None;
    keyboard_focus = None;
    mouse_capture = None;
    cursor_position = None;
    lshift = false;
    rshift = false;
    lctrl = false;
    rctrl = false;
    lalt = false;
    ralt = false;
  }

let create =
  let next_id = ref 0 in
  fun lay_out ->
    let id = !next_id in
    incr next_id;
    {
      id;
      widget_w = 10;
      widget_h = 10;
      parent = Invisible;
      widget_children = [];
      lay_out;
      draw = (fun ~x: _ ~y: _ ~w: _ ~h: _ -> ());
      on_key_down = [];
      on_key_up = [];
      on_mouse_down = [];
      on_mouse_up = [];
      on_mouse_move = [];
      on_mouse_wheel = [];
    }

let w (widget: laid_out) = widget.widget_w
let h (widget: laid_out) = widget.widget_h

(* Remove all links between widgets, to avoid memory leaks.
   Indeed, if we don't remove those links, holding a pointer to a single widget
   that is no longer visible means we keep in memory the whole tree that this widget
   once belonged to, except the part that is still visible.
   So when we recompute the layout, we clear the window first. *)
let clear_window window =
  let rec clear_widget (widget: t) =
    (
      iter widget.widget_children @@ fun { child; x = _; y = _ } ->
      clear_widget child
    );
    widget.widget_children <- [];
    widget.parent <- Invisible
  in
  match window.root with
    | None ->
        ()
    | Some root ->
        clear_widget root;
        window.root <- None

let get_position_in_parent widget =
  match widget.parent with
    | Invisible | Window _ ->
        0, 0
    | Widget parent ->
        let rec find_child = function
          | [] ->
              (* Broken invariant, the child is no longer a child but it does not know it. *)
              0, 0
          | head :: tail ->
              if head.child.id = widget.id then
                head.x, head.y
              else
                find_child tail
        in
        find_child parent.widget_children

let rec get_position_in_window widget =
  let parent_x, parent_y =
    match widget.parent with
      | Invisible | Window _ ->
          0, 0
      | Widget parent ->
          get_position_in_window parent
  in
  let widget_x, widget_y = get_position_in_parent widget in
  parent_x + widget_x, parent_y + widget_y

let get_center_in_window (widget: t) =
  let x, y = get_position_in_window widget in
  x + widget.widget_w / 2, y + widget.widget_h / 2

let is_not_empty = function [] -> false | _ :: _ -> true

let accepts_focus widget =
  is_not_empty widget.on_key_down ||
  is_not_empty widget.on_key_up

let rec focus_first_widget ~sort window widget =
  let rec find_accepting_child = function
    | [] ->
        false
    | child :: tail ->
        focus_first_widget ~sort window child.child || find_accepting_child tail
  in
  if find_accepting_child (sort widget.widget_children) then
    true
  else
    if accepts_focus widget then
      (
        window.keyboard_focus <- Some widget;
        true
      )
    else
      false

let focus_first ?(sort = fun l -> l) window =
  match window.root with
    | None ->
        window.keyboard_focus <- None
    | Some root ->
        if not (focus_first_widget ~sort window root) then
          window.keyboard_focus <- None

let focus_next ?(sort = fun l -> l) window =
  match window.keyboard_focus with
    | None ->
        focus_first ~sort window
    | Some current_focus ->
        let rec focus_next current_focus =
          match current_focus.parent with
            | Invisible | Window _ ->
                false
            | Widget parent ->
                let rec find_accepting_child = function
                  | [] ->
                      false
                  | child :: tail ->
                      focus_first_widget ~sort window child.child || find_accepting_child tail
                in
                let rec find_child = function
                  | [] ->
                      false
                  | child :: tail ->
                      if child.child.id = current_focus.id then
                        find_accepting_child tail
                      else
                        find_child tail
                in
                find_child (sort parent.widget_children) || focus_next parent
        in
        if not (focus_next current_focus) then focus_first ~sort window

let focus_last ?(sort = fun l -> l) window =
  let sort l = List.rev (sort l) in
  focus_first ~sort window

let focus_previous ?(sort = fun l -> l) window =
  let sort l = List.rev (sort l) in
  focus_next ~sort window

let rec filter_widgets ?(acc = []) f (root: t) =
  let acc = if f root then root :: acc else acc in
  fold acc root.widget_children @@ fun acc { x = _; y = _; child } ->
  filter_widgets ~acc f child

(* [mx] and [my] are multipliers for distances for each axis.
   They are used by focus functions to prioritize widgets in a particular axis. *)
let sort_by_distance ~mx ~my (from_widget: t) widgets =
  let mx2 = mx * mx in
  let my2 = my * my in
  let x1, y1 = get_center_in_window from_widget in
  let distance2 to_widget =
    let x2, y2 = get_center_in_window to_widget in
    let dx = x1 - x2 in
    let dy = y1 - y2 in
    mx2 * dx * dx + my2 * dy * dy
  in
  let by_distance a b =
    let da = distance2 a in
    let db = distance2 b in
    Int.compare da db
  in
  List.sort by_distance widgets

let focus_next_by_distance ~mx ~my window filter =
  match window.keyboard_focus with
    | None ->
        focus_first window
    | Some current_focus ->
        match window.root with
          | None ->
              window.keyboard_focus <- None
          | Some root ->
              let fx, fy = get_center_in_window current_focus in
              let filter widget =
                if accepts_focus widget then
                  let x, y = get_center_in_window widget in
                  filter ~fx ~fy ~x ~y
                else
                  false
              in
              let widgets = filter_widgets filter root in
              let widgets = sort_by_distance ~mx ~my current_focus widgets in
              let rec find_first_different = function
                | [] ->
                    (* Keep current focus. *)
                    ()
                | head :: tail ->
                    if head.id = current_focus.id then
                      find_first_different tail
                    else
                      window.keyboard_focus <- Some head
              in
              find_first_different widgets

let focus_right window =
  focus_next_by_distance ~mx: 1 ~my: 10 window @@ fun ~fx ~fy: _ ~x ~y: _ -> x > fx

let focus_left window =
  focus_next_by_distance ~mx: 1 ~my: 10 window @@ fun ~fx ~fy: _ ~x ~y: _ -> x < fx

let focus_down window =
  focus_next_by_distance ~mx: 10 ~my: 1 window @@ fun ~fx: _ ~fy ~x: _ ~y -> y > fy

let focus_up window =
  focus_next_by_distance ~mx: 10 ~my: 1 window @@ fun ~fx: _ ~fy ~x: _ ~y -> y < fy

let visible window widget =
  let rec in_tree root =
    widget.id = root.id ||
    exists root.widget_children (fun child -> in_tree child.child)
  in
  match window.root with
    | None ->
        false
    | Some root ->
        in_tree root

let lay_out widget { available_w; available_h } =
  let available_space =
    let fix = function
      | None -> None
      | Some x as o -> if x < 1 then Some 1 else o
    in
    {
      available_w = fix available_w;
      available_h = fix available_h;
    }
  in
  let { w; h; children } = widget.lay_out available_space in
  widget.widget_w <- w;
  widget.widget_h <- h;
  widget.widget_children <- children;
  (
    iter children @@ fun { child; x = _; y = _ } ->
    child.parent <- Widget widget;
  );
  widget

let lay_out_window window root available_space =
  clear_window window;
  window.root <- Some root;
  root.parent <- Window window;
  let _: laid_out = lay_out root available_space in
  (
    match window.keyboard_focus with
      | None ->
          focus_first window
      | Some widget ->
          if not (visible window widget) then
            focus_first window
  );
  (
    match window.mouse_capture with
      | None ->
          ()
      | Some widget ->
          if not (visible window widget) then
            window.mouse_capture <- None
  )

let set_draw widget f =
  widget.draw <- f

let on_key_down widget f =
  widget.on_key_down <- f :: widget.on_key_down

let on_key_up widget f =
  widget.on_key_up <- f :: widget.on_key_up

let on_mouse_down widget f =
  widget.on_mouse_down <- f :: widget.on_mouse_down

let on_mouse_up widget f =
  widget.on_mouse_up <- f :: widget.on_mouse_up

let on_mouse_move widget f =
  widget.on_mouse_move <- f :: widget.on_mouse_move

let on_mouse_wheel widget f =
  widget.on_mouse_wheel <- f :: widget.on_mouse_wheel

let rec set_window_focus window widget =
  if accepts_focus widget then
    window.keyboard_focus <- Some widget
  else
    match widget.parent with
      | Invisible | Window _ ->
          ()
      | Widget parent ->
          set_window_focus window parent

let rec get_window widget =
  match widget.parent with
    | Invisible ->
        None
    | Window window ->
        Some window
    | Widget parent ->
        get_window parent

let focus widget =
  match get_window widget with
    | None ->
        ()
    | Some window ->
        set_window_focus window widget

let has_focus widget =
  match get_window widget with
    | None ->
        false
    | Some window ->
        match window.keyboard_focus with
          | None ->
              false
          | Some focus ->
              focus.id = widget.id

let is_captured widget =
  match get_window widget with
    | None ->
        false
    | Some window ->
        match window.mouse_capture with
          | None ->
              false
          | Some capture ->
              capture.id = widget.id

let rec is_transitive_child_or_equal ~parent ~child =
  if parent.id = child.id then
    true
  else
    match child.parent with
      | Invisible | Window _ ->
          false
      | Widget new_child ->
          is_transitive_child_or_equal ~parent ~child: new_child

let has_focus_transitively widget =
  match get_window widget with
    | None ->
        false
    | Some window ->
        match window.keyboard_focus with
          | None ->
              false
          | Some focus ->
              is_transitive_child_or_equal ~parent: widget ~child: focus

let is_captured_transitively widget =
  match get_window widget with
    | None ->
        false
    | Some window ->
        match window.mouse_capture with
          | None ->
              false
          | Some capture ->
              is_transitive_child_or_equal ~parent: widget ~child: capture

let rec draw_widget ~x ~y ~w ~h (widget: t) =
  let w = min w widget.widget_w in
  let h = min h widget.widget_h in
  widget.draw ~x ~y ~w ~h;
  iter widget.widget_children @@ fun { x = child_x; y = child_y; child } ->
  draw_widget ~x: (x + child_x) ~y: (y + child_y) ~w: (w - child_x) ~h: (h - child_y) child

let draw ?(x = 0) ?(y = 0) ?w ?h window =
  match window.root with
    | None ->
        ()
    | Some root ->
        let w = match w with None -> root.widget_w | Some w -> min w root.widget_w in
        let h = match h with None -> root.widget_h | Some h -> min h root.widget_h in
        draw_widget ~x ~y ~w ~h root

let rec propagate_up widget get_handlers apply_handler =
  let rec propagate = function
    | [] ->
        (
          match widget.parent with
            | Invisible | Window _ ->
                Ignore
            | Widget parent ->
                propagate_up parent get_handlers apply_handler
        )
    | handler :: tail ->
        match apply_handler widget handler with
          | Capture ->
              Capture
          | Ignore ->
              propagate tail
  in
  propagate (get_handlers widget)

let default_key_down_handler window (event: key_down_event) =
  match Key.code event.key with
    | Tab ->
        if event.shift then
          focus_previous window
        else
          focus_next window
    | Right ->
        focus_right window
    | Left ->
        focus_left window
    | Down ->
        focus_down window
    | Up ->
        focus_up window
    | _ ->
        (* TODO: arrows, maybe Escape to remove mouse capture *)
        ()

let key_down window ~key ~repeat =
  (
    match Key.code key with
      | Lshift -> window.lshift <- true
      | Rshift -> window.rshift <- true
      | Lctrl -> window.lctrl <- true
      | Rctrl -> window.rctrl <- true
      | Lalt -> window.lalt <- true
      | Ralt -> window.ralt <- true
      | _ -> ()
  );
  let event =
    {
      key;
      shift = window.lshift || window.rshift;
      ctrl = window.lctrl || window.rctrl;
      alt = window.lalt || window.ralt;
      repeat;
    }
  in
  match
    match window.keyboard_focus with
      | None ->
          Ignore
      | Some widget ->
          match
            propagate_up widget (fun widget -> widget.on_key_down) @@ fun _ handler ->
            handler event
          with
            | Capture ->
                Capture
            | Ignore ->
                Ignore
  with
    | Capture ->
        ()
    | Ignore ->
        default_key_down_handler window event

(* TODO: would it make sense to only have widgets which received the key down
   events also receive the repetitions and the key up events for the same key? *)
let key_up window ~key =
  (
    match Key.code key with
      | Lshift -> window.lshift <- false
      | Rshift -> window.rshift <- false
      | Lctrl -> window.lctrl <- false
      | Rctrl -> window.rctrl <- false
      | Lalt -> window.lalt <- false
      | Ralt -> window.ralt <- false
      | _ -> ()
  );
  match window.keyboard_focus with
    | None ->
        ()
    | Some widget ->
        let event =
          {
            key;
            shift = window.lshift || window.rshift;
            ctrl = window.lctrl || window.rctrl;
            alt = window.lalt || window.ralt;
          }
        in
        let _: handler_result =
          propagate_up widget (fun widget -> widget.on_key_up) @@ fun _ handler ->
          handler event
        in
        ()

let rec get_widget_at (widget: t) ~x ~y =
  if x < 0 || y < 0 || x >= widget.widget_w || y >= widget.widget_h then
    None
  else
    let rec find_child = function
      | [] ->
          Some widget
      | head :: tail ->
          match get_widget_at head.child ~x: (x - head.x) ~y: (y - head.y) with
            | None ->
                find_child tail
            | Some _ as result ->
                result
    in
    find_child widget.widget_children

let get_mouse_event_receiving_widget window ~x ~y =
  match window.mouse_capture with
    | Some _ as result ->
        result
    | None ->
        match window.root with
          | None ->
              None
          | Some root ->
              match get_widget_at root ~x ~y with
                | None ->
                    None
                | Some _ as result ->
                    result

let trigger_mouse_button_event_handler ~button ~x ~y widget handler =
  let widget_x, widget_y = get_position_in_window widget in
  handler {
    button;
    x = x - widget_x;
    y = y - widget_y;
  }

let trigger_mouse_move_event_handler ~x ~y widget handler =
  let widget_x, widget_y = get_position_in_window widget in
  handler {
    x = x - widget_x;
    y = y - widget_y;
  }

let trigger_mouse_wheel_event_handler ~x ~y _widget handler =
  handler { x; y }

let mouse_down window ~button ~x ~y =
  window.cursor_position <- Some (x, y);
  let widget = get_mouse_event_receiving_widget window ~x ~y in
  if button = Mouse_button.Left then (
    window.mouse_capture <- widget;
    match widget with
      | None ->
          ()
      | Some widget ->
          set_window_focus window widget
  );
  match widget with
    | None ->
        ()
    | Some widget ->
        let _: handler_result =
          propagate_up widget (fun widget -> widget.on_mouse_down)
            (trigger_mouse_button_event_handler ~button ~x ~y)
        in
        ()

let mouse_up window ~button ~x ~y =
  window.cursor_position <- Some (x, y);
  let widget = get_mouse_event_receiving_widget window ~x ~y in
  if button = Mouse_button.Left then window.mouse_capture <- None;
  match widget with
    | None ->
        ()
    | Some widget ->
        let _: handler_result =
          propagate_up widget (fun widget -> widget.on_mouse_up)
            (trigger_mouse_button_event_handler ~button ~x ~y)
        in
        ()

let mouse_move window ~x ~y =
  window.cursor_position <- Some (x, y);
  match get_mouse_event_receiving_widget window ~x ~y with
    | None ->
        ()
    | Some widget ->
        let _: handler_result =
          propagate_up widget (fun widget -> widget.on_mouse_move)
            (trigger_mouse_move_event_handler ~x ~y)
        in
        ()

let mouse_wheel window ~x ~y =
  match window.cursor_position with
    | None ->
        ()
    | Some (cx, cy) ->
        match get_mouse_event_receiving_widget window ~x: cx ~y: cy with
          | None ->
              ()
          | Some widget ->
              let _: handler_result =
                propagate_up widget (fun widget -> widget.on_mouse_wheel)
                  (trigger_mouse_wheel_event_handler ~x ~y)
              in
              ()

let widget_at_cursor window =
  match window.cursor_position, window.root with
    | None, _ | _, None ->
        None
    | Some (x, y), Some root ->
        get_widget_at root ~x ~y

let mouse_is_captured window =
  match window.mouse_capture with
    | None ->
        false
    | Some _ ->
        true

let is_under_cursor widget =
  match get_window widget with
    | None ->
        false
    | Some window ->
        match widget_at_cursor window with
          | None ->
              false
          | Some widget_at_cursor ->
              widget_at_cursor.id = widget.id

let is_under_cursor_transitively widget =
  match get_window widget with
    | None ->
        false
    | Some window ->
        match widget_at_cursor window with
          | None ->
              false
          | Some widget_at_cursor ->
              is_transitive_child_or_equal ~parent: widget ~child: widget_at_cursor

let is_virtually_under_cursor widget =
  match get_window widget with
    | None ->
        false
    | Some window ->
        if mouse_is_captured window then
          is_captured_transitively widget && is_under_cursor widget
        else
          is_under_cursor widget

let is_virtually_under_cursor_transitively widget =
  match get_window widget with
    | None ->
        false
    | Some window ->
        if mouse_is_captured window then
          is_captured_transitively widget && is_under_cursor_transitively widget
        else
          is_under_cursor_transitively widget

let on_click widget f =
  let clicking = ref false in
  (
    on_mouse_down widget @@ fun event ->
    if event.button = Mouse_button.Left then
      (
        clicking := true;
        Capture
      )
    else
      Ignore
  );
  (
    on_mouse_up widget @@ fun event ->
    if !clicking && event.button = Left then
      (
        clicking := false;
        if is_under_cursor_transitively widget then f ();
        Capture
      )
    else
      Ignore
  );
  (
    on_key_down widget @@ fun event ->
    match Key.code event.key with
      | Return | Return2 | Kp_enter ->
          (* TODO: What is Return2? *)
          f ();
          Capture
      | _ ->
          Ignore
  );
  ()
