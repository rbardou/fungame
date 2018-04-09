module type IMAGE =
sig
  type t

  val width: t -> int
  val height: t -> int

  val draw:
    src_x: int -> src_y: int -> w: int -> h: int ->
    x: int -> y: int ->
    t -> unit
end

module type WIDGET =
sig
  type image
  type t

  val rect:
    ?w: int -> ?h: int ->
    ?color: (int * int * int * int) ->
    ?fill: bool ->
    unit -> t

  val image: image -> t

  module Button:
  sig
    type t
    val create: unit -> t
    val is_down: t -> bool
    val is_under_cursor: t -> bool
  end

  val button: Button.t -> (unit -> unit) -> t list -> t
  val right_clickable: (unit -> unit) -> t -> t

  val box: t list -> t

  val margin:
    ?left: int -> ?top: int -> ?right: int -> ?bottom: int -> ?all: int ->
    t -> t

  val margin_box:
    ?left: int -> ?top: int -> ?right: int -> ?bottom: int -> ?all: int ->
    t list -> t

  val at: int -> int -> t -> t
  val hbox: t list -> t
  val vbox: t list -> t
  val hsplit: float -> left: t -> right: t -> t
  val vsplit: float -> top: t -> bottom: t -> t
  val hsplitl: t list -> t
  val vsplitl: t list -> t
  val ratio: ?h: float -> ?v: float -> t -> t
  val left: t -> t
  val center: t -> t
  val right: t -> t
  val top: t -> t
  val middle: t -> t
  val bottom: t -> t

  type placed

  val place: w: int -> h: int -> t -> placed

  type draw_rect =
    x: int -> y: int -> w: int -> h: int ->
    color: (int * int * int * int) ->
    fill: bool ->
    unit

  val draw: draw_rect -> x: int -> y: int -> placed -> unit

  type state

  val start: unit -> state
  val mouse_down: state -> button: int -> x: int -> y: int -> placed -> bool
  val mouse_up: state -> button: int -> x: int -> y: int -> placed -> bool
  val mouse_move: state -> x: int -> y: int -> placed -> bool
end

module Make (Image: IMAGE): WIDGET with type image = Image.t =
struct

  type image = Image.t

  type rect =
    {
      color: int * int * int * int;
      fill: bool;
    }

  module Button =
  struct
    type t =
      {
        mutable is_down: bool;
        mutable is_under_cursor: bool;
      }

    let create () =
      {
        is_down = false;
        is_under_cursor = false;
      }

    let is_down button =
      button.is_down

    let is_under_cursor button =
      button.is_under_cursor
  end

  type t =
    | Rect of rect * int option * int option (* rect, w, h *)
    | Image of image
    | Button of t * Button.t * (unit -> unit)
    | Right_clickable of t * (unit -> unit)
    | Margin of t * int * int * int * int (* child, left, top, right, bottom *)
    | Box of t list
    | Hbox of t list
    | Vbox of t list
    | Hsplit of t * t * float (* left, right, ratio *)
    | Vsplit of t * t * float (* top, bottom, ratio *)
    | Ratio of t * float option * float option (* child, hratio, vratio *)

  let rect ?w ?h ?(color = 255, 0, 0, 255) ?(fill = false) () =
    Rect ({ color; fill }, w, h)

  let image image =
    Image image

  let box children =
    Box children

  let button state on_click children =
    Button (box children, state, on_click)

  let right_clickable on_click child =
    Right_clickable (child, on_click)

  let margin
      ?(left = 0) ?(top = 0) ?(right = 0) ?(bottom = 0) ?(all = 0)
      child =
    Margin (child, left + all, top + all, right + all, bottom + all)

  let margin_box ?left ?top ?right ?bottom ?all children =
    margin ?left ?top ?right ?bottom ?all (box children)

  let at x y child =
    margin ~left: x ~top: y child

  let hbox children =
    Hbox children

  let vbox children =
    Vbox children

  let hsplit ratio ~left ~right =
    Hsplit (left, right, ratio)

  let vsplit ratio ~top ~bottom =
    Vsplit (top, bottom, ratio)

  let splitl split children =
    let rec make count children =
      match children with
        | [] ->
            box []
        | [ child ] ->
            child
        | head :: tail ->
            split (1. /. float count) head (make (count - 1) tail)
    in
    make (List.length children) children

  let hsplitl children =
    splitl (fun ratio left right -> hsplit ratio ~left ~right) children

  let vsplitl children =
    splitl (fun ratio top bottom -> vsplit ratio ~top ~bottom) children

  let ratio ?h ?v child =
    match child with
      | Ratio (child, child_h, child_v) ->
          let h = match h with None -> child_h | Some _ -> h in
          let v = match v with None -> child_v | Some _ -> v in
          Ratio (child, h, v)
      | _ ->
          Ratio (child, h, v)

  let left child = ratio ~h: 0. child
  let center child = ratio ~h: 0.5 child
  let right child = ratio ~h: 1. child

  let top child = ratio ~v: 0. child
  let middle child = ratio ~v: 0.5 child
  let bottom child = ratio ~v: 1. child

  type kind =
    | Box
    | Rect of rect
    | Image of image
    | Button of Button.t * (unit -> unit)
    | Right_clickable of (unit -> unit)

  type placed =
    {
      x: int; (* relative to parent *)
      y: int; (* relative to parent *)
      w: int;
      h: int;
      kind: kind;
      children: placed list;
    }

  (* [place] calls itself recursively.
     When placing children, it overrides their position;
     so [place] always returns a widget with [x = 0] and [y = 0]. *)
  let rec place parent_w parent_h (ui: t): placed =
    let widget: placed =
      match ui with

        | Rect (rect, w, h) ->
            {
              x = 0;
              y = 0;
              w = (match w with None -> parent_w | Some w -> w);
              h = (match h with None -> parent_h | Some h -> h);
              kind = Rect rect;
              children = [];
            }

        | Image image ->
            {
              x = 0;
              y = 0;
              w = Image.width image;
              h = Image.height image;
              kind = Image image;
              children = [];
            }

        | Button (child, state, on_click) ->
            let child = place parent_w parent_h child in
            {
              x = 0;
              y = 0;
              w = child.w;
              h = child.h;
              kind = Button (state, on_click);
              children = [ child ];
            }

        | Right_clickable (child, on_click) ->
            let child = place parent_w parent_h child in
            {
              x = 0;
              y = 0;
              w = child.w;
              h = child.h;
              kind = Right_clickable on_click;
              children = [ child ];
            }

        | Margin (child, left, top, right, bottom) ->
            let child =
              place
                (parent_w - left - right)
                (parent_h - top - bottom)
                child
            in
            let child = { child with x = left; y = top } in
            {
              x = 0;
              y = 0;
              w = child.w + left + right;
              h = child.h + top + bottom;
              kind = Box;
              children = [ child ];
            }

        | Box children ->
            let children =
              List.map (place parent_w parent_h) children
            in
            let w, h =
              let max_size (w, h) child =
                max w child.w,
                max h child.h
              in
              List.fold_left max_size (0, 0) children
            in
            {
              x = 0;
              y = 0;
              w;
              h;
              kind = Box;
              children;
            }

        | Hbox children ->
            let place_child (previous_w, acc) child =
              let child =
                place
                  (parent_w - previous_w)
                  parent_h
                  child
              in
              let child = { child with x = previous_w } in
              previous_w + child.w, child :: acc
            in
            let w, children =
              List.fold_left place_child (0, []) children
            in
            let children = List.rev children in
            let h =
              let max_size h child = max h child.h in
              List.fold_left max_size 0 children
            in
            {
              x = 0;
              y = 0;
              w;
              h;
              kind = Box;
              children;
            }

        | Vbox children ->
            let place_child (previous_h, acc) child =
              let child =
                place
                  parent_w
                  (parent_h - previous_h)
                  child
              in
              let child = { child with y = previous_h } in
              previous_h + child.h, child :: acc
            in
            let h, children =
              List.fold_left place_child (0, []) children
            in
            let children = List.rev children in
            let w =
              let max_size w child = max w child.w in
              List.fold_left max_size 0 children
            in
            {
              x = 0;
              y = 0;
              w;
              h;
              kind = Box;
              children;
            }

        | Hsplit (left, right, ratio) ->
            let left_w = int_of_float (float parent_w *. ratio) in
            let left =
              place
                left_w
                parent_h
                left
            in
            let right =
              place
                (parent_w - left_w)
                parent_h
                right
            in
            let right = { right with x = left_w } in
            {
              x = 0;
              y = 0;
              w = parent_w;
              h = parent_h;
              kind = Box;
              children = [ left; right ];
            }

        | Vsplit (top, bottom, ratio) ->
            let top_h = int_of_float (float parent_h *. ratio) in
            let top =
              place
                parent_w
                top_h
                top
            in
            let bottom =
              place
                parent_w
                (parent_h - top_h)
                bottom
            in
            let bottom = { bottom with y = top_h } in
            {
              x = 0;
              y = 0;
              w = parent_w;
              h = parent_h;
              kind = Box;
              children = [ top; bottom ];
            }

        | Ratio (child, hratio, vratio) ->
            let child = place parent_w parent_h child in
            let child =
              let x =
                match hratio with
                  | None ->
                      0
                  | Some hratio ->
                      int_of_float (
                        float parent_w *. hratio -. float child.w *. hratio
                      )
              in
              let y =
                match vratio with
                  | None ->
                      0
                  | Some vratio ->
                      int_of_float (
                        float parent_h *. vratio -. float child.h *. vratio
                      )
              in
              { child with x; y }
            in
            {
              x = 0;
              y = 0;
              w = (match hratio with None -> child.w | Some _ -> parent_w);
              h = (match vratio with None -> child.h | Some _ -> parent_h);
              kind = Box;
              children = [ child ];
            }

    in
    { widget with w = min parent_w widget.w; h = min parent_h widget.h }

  let place ~w ~h ui =
    place w h ui

  type draw_rect =
    x: int -> y: int -> w: int -> h: int ->
    color: (int * int * int * int) ->
    fill: bool ->
    unit

  let rec draw draw_rect ~x ~y (widget: placed) =
    let x = x + widget.x in
    let y = y + widget.y in
    (
      match widget.kind with
        | Rect rect ->
            draw_rect ~x ~y ~w: widget.w ~h: widget.h
              ~color: rect.color ~fill: rect.fill
        | Image image ->
            (* TODO: src_x and src_y *)
            Image.draw ~src_x: 0 ~src_y: 0 ~x ~y ~w: widget.w ~h: widget.h image
        | _ ->
            ()
    );
    List.iter (draw draw_rect ~x ~y) widget.children

  let point_in_rect ~x ~y ~rx ~ry ~rw ~rh =
    x >= rx &&
    x < rx + rw &&
    y >= ry &&
    y < ry + rh

  let point_in_widget ~x ~y (widget: placed) =
    point_in_rect x y widget.x widget.y widget.w widget.h

  (* We store absolute coordinates at the time the button was pressed.
     We assume the widget has not moved when the button is released. *)
  type being_clicked =
    | None
    | Button of Button.t * int * int * int * int * (unit -> unit)

  type under_cursor =
    | None
    | Button of Button.t

  (* We could also iterate over the widget tree to find widgets, but this
     would probably be significantly less efficient. *)
  type state =
    {
      mutable being_clicked: being_clicked;
      mutable under_cursor: under_cursor;
    }

  let start () =
    {
      being_clicked = None;
      under_cursor = None;
    }

  let left_mouse_button = 1
  let right_mouse_button = 3

  let rec mouse_down (state: state) ~parent_x ~parent_y ~button ~x ~y
      (widget: placed) =
    if point_in_widget ~x ~y widget then
      match widget.kind with
        | Button (button_state, on_click) when button = left_mouse_button ->
            state.being_clicked <-
              Button (
                button_state,
                parent_x + widget.x,
                parent_y + widget.y,
                widget.w,
                widget.h,
                on_click
              );
            button_state.is_down <- true;
            true
        | Right_clickable on_click when button = right_mouse_button ->
            on_click ();
            true
        | _ ->
            let rec loop = function
              | [] ->
                  false
              | head :: tail ->
                  if
                    mouse_down
                      state
                      ~parent_x: (parent_x + widget.x)
                      ~parent_y: (parent_y + widget.y)
                      ~button
                      ~x: (x - widget.x)
                      ~y: (y - widget.y)
                      head
                  then
                    true
                  else
                    loop tail
            in
            loop widget.children
    else
      false

  let mouse_down = mouse_down ~parent_x: 0 ~parent_y: 0

  let rec mouse_up (state: state) ~button ~x ~y (widget: placed) =
    match state.being_clicked with
      | Button (button_state, rx, ry, rw, rh, on_click)
        when button = left_mouse_button ->
          state.being_clicked <- None;
          button_state.is_down <- false;
          if point_in_rect ~x ~y ~rx ~ry ~rw ~rh then
            (
              on_click ();
              true
            )
          else
            false
      | _ ->
          false

  let rec mouse_move (state: state) ~x ~y (widget: placed) =
    if point_in_widget ~x ~y widget then
      match widget.kind with
        | Button (button, _) ->
            state.under_cursor <- Button button;
            button.is_under_cursor <- true;
            true
        | _ ->
            let rec loop = function
              | [] ->
                  false
              | head :: tail ->
                  if
                    mouse_move
                      state
                      ~x: (x - widget.x)
                      ~y: (y - widget.y)
                      head
                  then
                    true
                  else
                    loop tail
            in
            loop widget.children
    else
      false

  let mouse_move (state: state) ~x ~y (widget: placed) =
    (
      match state.under_cursor with
        | None -> ()
        | Button button -> button.is_under_cursor <- false
    );
    state.under_cursor <- None;
    mouse_move state ~x ~y widget

end
