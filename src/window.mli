(** Window creation and management. *)

(** Windows. *)
type t

(** Create a new window.

    Default title is ["Fungame"].
    Default size is [640 * 480].

    If [vsync] is [true] (which it is by default), vertical synchronization with
    the monitor is active, which prevents tearing. This means that the CPU will
    be idle while waiting for vertical synchronization though.

    Note that multiple windows are not really supported. *)
val create: ?title: string -> ?w: int -> ?h: int -> ?vsync: bool -> unit -> t

(** Get the width of a window. *)
val w: t -> int

(** Get the height of a window. *)
val h: t -> int

(** Clear window with a given color. *)
val clear: t -> Color.t -> unit

(** Draw a rectangle. *)
val draw_rect:
  t -> x: int -> y: int -> w: int -> h: int -> color: Color.t -> fill: bool -> unit

(** Close a window.

    Automatically called by [Main.run]. *)
val close: t -> unit

(** Get the SDL renderer of a window. *)
val renderer: t -> Tsdl.Sdl.renderer
