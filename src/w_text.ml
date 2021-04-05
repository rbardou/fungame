let create ?color ?(wrap = false) font text =
  let used_wrap = ref None in
  let widget =
    Widget.create @@ fun { available_w; available_h } ->
    (* Render text to get the dimensions.
       We will re-render the text to draw it but thanks to memoization
       we will just reuse this image.
       An alternative would be to render it once and for all, but since
       we want to be able to create widgets on the fly easily, it would lead to
       images being created each time the widget is re-created. *)
    let image =
      let wrap =
        if wrap then
          available_w
        else
          None
      in
      (* Store the wrap parameters so that when drawing, we reuse the same value
         to benefit from memoization. *)
      used_wrap := wrap;
      Font.render_memoized ?color ?wrap font text
    in
    let w = Image.w image in
    let h = Image.h image in
    {
      w = (
        match available_w with
          | None -> w
          | Some aw -> min w aw
      );
      h = (
        match available_h with
          | None -> h
          | Some ah -> min h ah
      );
      children = [];
    }
  in
  (
    Widget.set_draw widget @@ fun ~x ~y ~w ~h ->
    (* Need to re-render in case the image was destroyed. *)
    let image = Font.render_memoized ?color ?wrap: !used_wrap font text in
    Image.draw ~x ~y ~w ~h image
  );
  widget
