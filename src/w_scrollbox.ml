let create_vertical (layout: Layout.t) =
  let offset_y = ref 0 in
  let widget =
    Widget.create @@ fun (available_space: Widget.available_space) ->
    let layout =
      layout {
        available_w = available_space.available_w;
        available_h = None;
      }
    in
    let max_offset =
      match available_space.available_h with
        | None -> 0
        | Some h -> max 0 (layout.h - h)
    in
    offset_y := min 0 (max (- max_offset) !offset_y);
    let children =
      List.map
        (fun (child: Widget.child) -> { child with y = child.y + !offset_y })
        layout.children
    in
    {
      w = layout.w;
      h = (
        match available_space.available_h with
          | None -> layout.h
          | Some h -> min h layout.h
      );
      children;
    }
  in
  (
    Widget.on_mouse_wheel widget @@ fun { y; _ } ->
    offset_y := !offset_y + 20 * y;
    Capture
  );
  widget
