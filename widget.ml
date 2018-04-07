module type IMAGE =
sig
  type t

  (** Get the width of an image. *)
  val width: t -> int

  (** Get the height of an image. *)
  val height: t -> int

  (** Draw an image.

      [src_x, src_y, w, h] determines the part of the image to be drawn.
      [x, y] are the destination position. *)
  val draw:
    src_x: int -> src_y: int -> w: int -> h: int ->
    x: int -> y: int ->
    t -> unit

  (** Draw a rectangle. *)
  val draw_rect:
    x: int -> y: int -> w: int -> h: int ->
    color: (int * int * int * int) ->
    fill: bool ->
    unit
end

module type WIDGET =
sig
  type image
  type t

  (** Make a widget which draws as a rectangle.

      Take all available width unless [w] is specified.
      Take all available height unless [h] is specified.

      If [fill] is [true], draw the inside of the rectangle as well.
      Default is [false].

      Default [color] is red ([255, 0, 0, 255]). *)
  val rect:
    ?w: int -> ?h: int ->
    ?color: (int * int * int * int) ->
    ?fill: bool ->
    unit -> t

  (** Make a widget which draws as an image. *)
  val image: image -> t

  (** Group some widgets together. *)
  val box: t list -> t

  (** Box widgets (like [box]) and add margins. *)
  val margin:
    ?left: int -> ?top: int -> ?right: int -> ?bottom: int -> ?all: int ->
    t -> t

  (** [margin children] is the same as [margin (box children)]. *)
  val margin_box:
    ?left: int -> ?top: int -> ?right: int -> ?bottom: int -> ?all: int ->
    t list -> t

  (** Place some widgets next to each other horizontally and box them. *)
  val hbox: t list -> t

  (** Place some widgets next to each other vertically and box them. *)
  val vbox: t list -> t

  (** Split a widget into a left and a right part at a given ratio. *)
  val hsplit: float -> left: t -> right: t -> t

  (** Split a widget into a top and a bottom part at a given ratio. *)
  val vsplit: float -> top: t -> bottom: t -> t

  (** Split a widget horizontally (like [hsplit]) equally. *)
  val hsplitl: t list -> t

  (** Split a widget vertically (like [vsplit]) equally. *)
  val vsplitl: t list -> t

  (** Place a widget relatively to its parent.

      For instance, [ratio ~h: 0.5 ~v: 1. child] places the center-bottom part
      of [child] at the center-bottom part of its parent.

      If [h] is specified, return a widget with the width of its parent
      (so that the child can be placed inside this width).
      Similarly, if [v] is specified, return a widget with the height of its
      parent.

      As a special case, [ratio ~h (ratio ~v child)] and
      [ratio ~v (ratio ~h child)] are modified to actually be
      [ratio ~h ~v child]. This means you can write [widget |> center |> bottom]
      for instance. *)
  val ratio: ?h: float -> ?v: float -> t -> t

  (** Same as [ratio ~h: 0.]. *)
  val left: t -> t

  (** Same as [ratio ~h: 0.5]. *)
  val center: t -> t

  (** Same as [ratio ~h: 1.]. *)
  val right: t -> t

  (** Same as [ratio ~v: 0.]. *)
  val top: t -> t

  (** Same as [ratio ~v: 0.5]. *)
  val middle: t -> t

  (** Same as [ratio ~v: 1.]. *)
  val bottom: t -> t

  (** Widgets whose placement has been computed. *)
  type placed

  (** Compute placement of widgets.

      [w, h] give the available space.  *)
  val place: w: int -> h: int -> t -> placed

  (** Draw widgets. *)
  val draw: x: int -> y: int -> placed -> unit
end

module Make (Image: IMAGE): WIDGET with type image = Image.t =
struct
  type image = Image.t

  type rect =
    {
      color: int * int * int * int;
      fill: bool;
    }

  type t =
    | Rect of rect * int option * int option (* rect, w, h *)
    | Image of image
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

  let margin
      ?(left = 0) ?(top = 0) ?(right = 0) ?(bottom = 0) ?(all = 0)
      child =
    Margin (child, left + all, top + all, right + all, bottom + all)

  let margin_box ?left ?top ?right ?bottom ?all children =
    margin ?left ?top ?right ?bottom ?all (box children)

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

  let rec draw ~x ~y (widget: placed) =
    let x = x + widget.x in
    let y = y + widget.y in
    (
      match widget.kind with
        | Box ->
            ()
        | Rect rect ->
            Image.draw_rect ~x ~y ~w: widget.w ~h: widget.h
              ~color: rect.color ~fill: rect.fill
        | Image image ->
            (* TODO: src_x and src_y *)
            Image.draw ~src_x: 0 ~src_y: 0 ~x ~y ~w: widget.w ~h: widget.h image
    );
    List.iter (draw ~x ~y) widget.children;
end
