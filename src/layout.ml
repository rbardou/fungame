open Widget

type t = Widget.available_space -> Widget.layout

let empty ?(w = 0) ?(h = 0) () = fun _ ->
  {
    w;
    h;
    children = [];
  }

let put ?(x = 0) ?(y = 0) ?w ?h child: t = fun available_space ->
  let child =
    Widget.lay_out child {
      available_w = (match w with None -> available_space.available_w | Some _ -> w);
      available_h = (match h with None -> available_space.available_h | Some _ -> h);
    }
  in
  {
    w = x + Widget.w child;
    h = y + Widget.h child;
    children = [ { x; y; child } ];
  }

let box (lay_out_list: t list): t = fun available_space ->
  let layouts = List.map (fun lay_out -> lay_out available_space) lay_out_list in
  let w, h, children =
    let merge (acc_w, acc_h, acc_children) { Widget.w; h; children } =
      max acc_w w,
      max acc_h h,
      List.rev_append children acc_children
    in
    List.fold_left merge (0, 0, []) layouts
  in
  {
    w;
    h;
    children = List.rev children;
  }

let hbox ?(sep = 0) ?(center = false) (lay_out_list: t list): t = fun available_space ->
  let layouts =
    match available_space.available_w with
      | None ->
          List.map (fun lay_out -> lay_out available_space) lay_out_list
      | Some aw ->
          let lay_out_one (aw, acc) lay_out =
            let layout =
              lay_out {
                available_w = Some aw;
                available_h = available_space.available_h;
              }
            in
            aw - layout.w - sep, layout :: acc
          in
          List.fold_left lay_out_one (aw, []) lay_out_list |> snd |> List.rev
  in
  let max_h = List.fold_left (fun acc { Widget.h; _ } -> max acc h) 0 layouts in
  let w, children =
    let merge (acc_w, acc_children) { Widget.w; h; children } =
      let move { Widget.x; y; child } =
        {
          x = acc_w + x;
          y = (
            if center then
              y + (max_h - h) / 2
            else
              y
          );
          child
        }
      in
      acc_w + w + sep,
      List.rev_append (List.map move children) acc_children
    in
    List.fold_left merge (0, []) layouts
  in
  {
    w = w - sep;
    h = max_h;
    children = List.rev children;
  }

let vbox ?(sep = 0) ?(center = false) (lay_out_list: t list): t = fun available_space ->
  let layouts =
    match available_space.available_h with
      | None ->
          List.map (fun lay_out -> lay_out available_space) lay_out_list
      | Some ah ->
          let lay_out_one (ah, acc) lay_out =
            let layout =
              lay_out {
                available_w = available_space.available_w;
                available_h = Some ah;
              }
            in
            ah - layout.h - sep, layout :: acc
          in
          List.fold_left lay_out_one (ah, []) lay_out_list |> snd |> List.rev
  in
  let max_w = List.fold_left (fun acc { Widget.w; _ } -> max acc w) 0 layouts in
  let h, children =
    let merge (acc_h, acc_children) { Widget.w; h; children } =
      let move { Widget.x; y; child } =
        {
          x = (
            if center then
              x + (max_w - w) / 2
            else
              x
          );
          y = acc_h + y;
          child
        }
      in
      acc_h + h + sep,
      List.rev_append (List.map move children) acc_children
    in
    List.fold_left merge (0, []) layouts
  in
  {
    w = max_w;
    h = h - sep;
    children = List.rev children;
  }

let margin ?(left = 0) ?(right = 0) ?(top = 0) ?(bottom = 0)
    ?(horizontal = 0) ?(vertical = 0) ?(all = 0) (lay_out: t): t =
  fun { available_w; available_h } ->
  let left = left + horizontal + all in
  let right = right + horizontal + all in
  let top = top + vertical + all in
  let bottom = bottom + vertical + all in
  let layout =
    lay_out {
      available_w = Option.map (fun w -> w - left - right) available_w;
      available_h = Option.map (fun h -> h - top - bottom) available_h;
    }
  in
  let offset_child { Widget.x; y; child } =
    {
      Widget.x = x + left;
      Widget.y = y + top;
      child;
    }
  in
  {
    w = layout.w + left + right;
    h = layout.h + top + bottom;
    children = List.map offset_child layout.children;
  }

let size ?w ?h (lay_out: t): t =
  fun { available_w; available_h } ->
  let layout =
    lay_out {
      available_w = (match w with None -> available_w | Some _ -> w);
      available_h = (match h with None -> available_h | Some _ -> h);
    }
  in
  let w = match w with None -> layout.w | Some w -> w in
  let h = match h with None -> layout.h | Some h -> h in
  {
    w;
    h;
    children = layout.children;
  }

let fill (lay_out: t): t = fun available_space ->
  let layout = lay_out available_space in
  {
    w = (match available_space.available_w with None -> layout.w | Some w -> w);
    h = (match available_space.available_h with None -> layout.h | Some h -> h);
    children = layout.children;
  }

let hfill (lay_out: t): t = fun available_space ->
  let layout = lay_out available_space in
  {
    w = (match available_space.available_w with None -> layout.w | Some w -> w);
    h = layout.h;
    children = layout.children;
  }

let vfill (lay_out: t): t = fun available_space ->
  let layout = lay_out available_space in
  {
    w = layout.w;
    h = (match available_space.available_h with None -> layout.h | Some h -> h);
    children = layout.children;
  }

let center (lay_out: t): t = fun available_space ->
  let layout = lay_out available_space in
  let children_w, children_h =
    let max (acc_w, acc_h) { Widget.x; y; child } =
      max acc_w (x + Widget.w child), max acc_h (y + Widget.h child)
    in
    List.fold_left max (0, 0) layout.children
  in
  let children =
    let center_child { Widget.x; y; child } =
      let x =
        match available_space.available_w with
          | None -> x
          | Some aw -> x + (aw - children_w) / 2
      in
      let y =
        match available_space.available_h with
          | None -> y
          | Some ah -> y + (ah - children_h) / 2
      in
      { Widget.x; y; child }
    in
    List.map center_child layout.children
  in
  {
    w = (match available_space.available_w with None -> layout.w | Some w -> w);
    h = (match available_space.available_h with None -> layout.h | Some h -> h);
    children;
  }

let hcenter (lay_out: t): t = fun available_space ->
  let layout = lay_out available_space in
  let children_w =
    let max acc_w { Widget.x; y = _; child } = max acc_w (x + Widget.w child) in
    List.fold_left max 0 layout.children
  in
  let children =
    let center_child { Widget.x; y; child } =
      let x =
        match available_space.available_w with
          | None -> x
          | Some aw -> x + (aw - children_w) / 2
      in
      { Widget.x; y; child }
    in
    List.map center_child layout.children
  in
  {
    w = (match available_space.available_w with None -> layout.w | Some w -> w);
    h = layout.h;
    children;
  }

let vcenter (lay_out: t): t = fun available_space ->
  let layout = lay_out available_space in
  let children_h =
    let max acc_h { Widget.x = _; y; child } = max acc_h (y + Widget.h child) in
    List.fold_left max 0 layout.children
  in
  let children =
    let center_child { Widget.x; y; child } =
      let y =
        match available_space.available_h with
          | None -> y
          | Some ah -> y + (ah - children_h) / 2
      in
      { Widget.x; y; child }
    in
    List.map center_child layout.children
  in
  {
    w = layout.w;
    h = (match available_space.available_h with None -> layout.h | Some h -> h);
    children;
  }

let push (lay_out: t): t = fun available_space ->
  let layout = lay_out available_space in
  let children_w, children_h =
    let max (acc_w, acc_h) { Widget.x; y; child } =
      max acc_w (x + Widget.w child), max acc_h (y + Widget.h child)
    in
    List.fold_left max (0, 0) layout.children
  in
  let children =
    let center_child { Widget.x; y; child } =
      let x =
        match available_space.available_w with
          | None -> x
          | Some aw -> x + aw - children_w
      in
      let y =
        match available_space.available_h with
          | None -> y
          | Some ah -> y + ah - children_h
      in
      { Widget.x; y; child }
    in
    List.map center_child layout.children
  in
  {
    w = (match available_space.available_w with None -> layout.w | Some w -> w);
    h = (match available_space.available_h with None -> layout.h | Some h -> h);
    children;
  }

let hpush (lay_out: t): t = fun available_space ->
  let layout = lay_out available_space in
  let children_w =
    let max acc_w { Widget.x; y = _; child } = max acc_w (x + Widget.w child) in
    List.fold_left max 0 layout.children
  in
  let children =
    let center_child { Widget.x; y; child } =
      let x =
        match available_space.available_w with
          | None -> x
          | Some aw -> x + aw - children_w
      in
      { Widget.x; y; child }
    in
    List.map center_child layout.children
  in
  {
    w = (match available_space.available_w with None -> layout.w | Some w -> w);
    h = layout.h;
    children;
  }

let vpush (lay_out: t): t = fun available_space ->
  let layout = lay_out available_space in
  let children_h =
    let max acc_h { Widget.x = _; y; child } = max acc_h (y + Widget.h child) in
    List.fold_left max 0 layout.children
  in
  let children =
    let center_child { Widget.x; y; child } =
      let y =
        match available_space.available_h with
          | None -> y
          | Some ah -> y + ah - children_h
      in
      { Widget.x; y; child }
    in
    List.map center_child layout.children
  in
  {
    w = layout.w;
    h = (match available_space.available_h with None -> layout.h | Some h -> h);
    children;
  }

(* [min] and [max] are defined at the end to avoid shadowing [Stdlib]
   in the rest of this module. *)
let min ?w ?h (lay_out: t): t = fun { available_w; available_h } ->
  let layout =
    lay_out {
      available_w = (
        match available_w, w with
          | None, x | x, None -> x
          | Some aw, Some w -> Some (max w aw)
      );
      available_h = (
        match available_h, h with
          | None, x | x, None -> x
          | Some ah, Some h -> Some (max h ah)
      );
    }
  in
  {
    w = (match w with None -> layout.w | Some w -> max w layout.w);
    h = (match h with None -> layout.h | Some h -> max h layout.h);
    children = layout.children;
  }

and max ?w ?h (lay_out: t): t = fun { available_w; available_h } ->
  let layout =
    lay_out {
      available_w = (
        match available_w, w with
          | None, x | x, None -> x
          | Some aw, Some w -> Some (min w aw)
      );
      available_h = (
        match available_h, h with
          | None, x | x, None -> x
          | Some ah, Some h -> Some (min h ah)
      );
    }
  in
  {
    w = (match w with None -> layout.w | Some w -> min w layout.w);
    h = (match h with None -> layout.h | Some h -> min h layout.h);
    children = layout.children;
  }
