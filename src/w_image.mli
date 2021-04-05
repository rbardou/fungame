(** Image widgets. *)

(** Create a widget from an image.

    The widget takes at most the size of the image. *)
val create: Image.t -> Widget.t

(** Draw an image repeatedly to cover a rectangle. *)
val draw_background: Image.t -> x: int -> y: int -> w: int -> h: int -> unit

(** Create a widget that draws as a rectangle.

    [left], [right], [top] and [bottom] are repeated on the left, right, top and
    bottom. They can be used to draw rectangle borders, for instance.
    [top_left], [top_right], [bottom_left] and [bottom_right], if specified,
    are used for corners. The rest of the widget is covered by repeating the
    unlabeled image argument.

    This widget is typically used to draw rectangular backgrounds around other
    widgets. So it takes a function to place children as its last argument. *)
val create_background:
  ?left: Image.t ->
  ?right: Image.t ->
  ?top: Image.t ->
  ?bottom: Image.t ->
  ?top_left: Image.t ->
  ?top_right: Image.t ->
  ?bottom_left: Image.t ->
  ?bottom_right: Image.t ->
  Image.t -> (Widget.available_space -> Widget.layout) -> Widget.t
