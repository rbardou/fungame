(** IO-independant simple widget library. *)

(** Currently, keyboard is not supported as this library is designed
    for game development and keyboard is usually not used to navigate
    widgets in games like in desktop applications. *)

(** {2 Widget States} *)

(** Widget states such as [Button.t] contain information which should
    stay even when the widget tree is being rebuilt so that events
    work properly. So you should declare them once, not each time you
    rebuild the tree. You can re-create them if you want to reset
    their state though. *)

(** {2 Functor Input} *)

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
end

(** {2 Functor Output} *)

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

  module Button:
  sig
    type t

    (** Create a new button state, given an [on_click] event. *)
    val create: unit -> t

    (** Test whether a button is being pressed. *)
    val is_down: t -> bool

    (** Test whether a button is under the mouse cursor. *)
    val is_under_cursor: t -> bool
  end

  (** Make a button.

      Buttons can be clicked.
      A click starts when mouse button [1] is pressed on the widget.
      [is_down] is [true] until this mouse button is released.
      If the mouse button is released and the cursor is still on
      the widget, [on_click] is triggered. *)
  val button: Button.t -> (unit -> unit) -> t -> t

  (** Make a widget capable of receiving right click events.

      Contrary to left clicks on buttons, right clicks are triggered
      immediately when mouse button [3] is pressed, so no state is needed. *)
  val right_clickable: (unit -> unit) -> t -> t

  (** Group some widgets together. *)
  val box: t list -> t

  (** Box widgets (like [box]) and add margins. *)
  val margin:
    ?left: int -> ?top: int -> ?right: int -> ?bottom: int -> ?all: int ->
    t -> t

  (** [at x y] is the same as [margin ~left: x ~top: y]. *)
  val at: int -> int -> t -> t

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

  (** Set the size of a widget.

      Useful for widgets which, by default, take the size of their parent,
      such as [ratio]. *)
  val size: ?w: int -> ?h: int -> t -> t

  (** Widgets whose placement has been computed. *)
  type placed

  (** Compute placement of widgets.

      [w, h] give the available space.  *)
  val place: w: int -> h: int -> t -> placed

  (** Function used to draw rects. *)
  type draw_rect =
    x: int -> y: int -> w: int -> h: int ->
    color: (int * int * int * int) ->
    fill: bool ->
    unit

  (** Draw widgets. *)
  val draw: draw_rect -> x: int -> y: int -> placed -> unit

  (** {2 Events} *)

  (** Global widget state. *)
  type state

  (** Create a new global widget state. *)
  val start: unit -> state

  (** Event functions return [true] if they actually used the event. *)

  (** React to a mouse down event. *)
  val mouse_down: state -> button: int -> x: int -> y: int -> placed -> bool

  (** React to a mouse up event. *)
  val mouse_up: state -> button: int -> x: int -> y: int -> placed -> bool

  (** React to a mouse move event. *)
  val mouse_move: state -> x: int -> y: int -> placed -> bool
end

(** {2 Functor} *)

module Make (Image: IMAGE): WIDGET with type image = Image.t
