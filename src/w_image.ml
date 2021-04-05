let create image =
  let widget =
    Widget.create @@ fun { available_w; available_h } ->
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
    Image.draw ~x ~y ~w ~h image
  );
  widget

let draw_background image ~x ~y ~w ~h =
  let bw = Image.w image in
  let bh = Image.h image in
  for iy = 0 to h / bh + 1 do
    for ix = 0 to w / bw + 1 do
      Image.draw
        ~x: (x + ix * bw)
        ~y: (y + iy * bh)
        ~w: (min bw (w - ix * bw))
        ~h: (min bh (h - iy * bh))
        image
    done;
  done

let create_background ?left ?right ?top ?bottom
    ?top_left ?top_right ?bottom_left ?bottom_right
    image layout =
  let widget = Widget.create layout in
  (
    Widget.set_draw widget @@ fun ~x ~y ~w ~h ->
    (* Background. *)
    (
      let dx = match left with None -> 0 | Some i -> Image.w i in
      let dy = match top with None -> 0 | Some i -> Image.h i in
      let w = w - dx - (match right with None -> 0 | Some i -> Image.w i) in
      let h = h - dy - (match bottom with None -> 0 | Some i -> Image.h i) in
      draw_background image ~x: (x + dx) ~y: (y + dy) ~w ~h
    );
    (* Left border. *)
    (
      match left with
        | None ->
            ()
        | Some image ->
            let dy = match top_left with None -> 0 | Some i -> Image.h i in
            let h = h - dy - (match bottom_left with None -> 0 | Some i -> Image.h i) in
            let bh = Image.h image in
            for iy = 0 to h / bh + 1 do
              Image.draw
                ~x
                ~y: (y + dy + iy * bh)
                ~h: (min bh (h - iy * bh))
                image
            done;
    );
    (* Right border. *)
    (
      match right with
        | None ->
            ()
        | Some image ->
            let dy = match top_right with None -> 0 | Some i -> Image.h i in
            let h = h - dy - (match bottom_right with None -> 0 | Some i -> Image.h i) in
            let bw = Image.w image in
            let bh = Image.h image in
            for iy = 0 to h / bh + 1 do
              Image.draw
                ~x: (x + w - bw)
                ~y: (y + dy + iy * bh)
                ~h: (min bh (h - iy * bh))
                image
            done;
    );
    (* Top border. *)
    (
      match top with
        | None ->
            ()
        | Some image ->
            let dx = match top_left with None -> 0 | Some i -> Image.w i in
            let w = w - dx - (match top_right with None -> 0 | Some i -> Image.w i) in
            let bw = Image.w image in
            for ix = 0 to w / bw + 1 do
              Image.draw
                ~x: (x + dx + ix * bw)
                ~y
                ~w: (min bw (w - ix * bw))
                image
            done;
    );
    (* Bottom border. *)
    (
      match bottom with
        | None ->
            ()
        | Some image ->
            let dx = match bottom_left with None -> 0 | Some i -> Image.w i in
            let w = w - dx - (match bottom_right with None -> 0 | Some i -> Image.w i) in
            let bw = Image.w image in
            let bh = Image.h image in
            for ix = 0 to w / bw + 1 do
              Image.draw
                ~x: (x + dx + ix * bw)
                ~y: (y + h - bh)
                ~w: (min bw (w - ix * bw))
                image
            done;
    );
    (* Top-left corner. *)
    (
      match top_left with
        | None ->
            ()
        | Some image ->
            Image.draw ~x ~y image
    );
    (* Top-right corner. *)
    (
      match top_right with
        | None ->
            ()
        | Some image ->
            Image.draw ~x: (x + w - Image.w image) ~y image
    );
    (* Bottom-left corner. *)
    (
      match bottom_left with
        | None ->
            ()
        | Some image ->
            Image.draw ~x ~y: (y + h - Image.h image) image
    );
    (* Bottom-right corner. *)
    (
      match bottom_right with
        | None ->
            ()
        | Some image ->
            Image.draw ~x: (x + w - Image.w image) ~y: (y + h - Image.h image) image
    );
  );
  widget
