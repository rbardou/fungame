(** Simple library to make games using SDL. *)

(** This library handles inputs and outputs.
    It provides widgets that you can combine to describe both how to draw
    your game and how inputs (especially mouse inputs) are interpreted. *)

(** {2 Windows} *)

module Window:
sig
  type t

  (** Create a new window.
      Note that multiple windows are not really supported. *)
  val create: ?title: string -> ?w: int -> ?h: int -> unit -> t
end

(** {2 Images *)

module Image:
sig
  include Widget.IMAGE
  val load: Window.t -> string -> t
end

(** {2 Widgets *)

module Widget: Widget.WIDGET with type image = Image.t

(** {2 Main Loop} *)

(** Exit the main loop.

    Call this from widget events. *)
val quit: unit -> 'a

(** Run the game.

    Usage: [run make_ui]

    Call [make_ui] to build a widget list, then draw it and handle
    events. Then call [make_ui] again and start over, looping until
    the user exits.

    If [clear] is specified, clear screen using given color before drawing.

    If [auto_close_window] is [true], call [Window.close] at the end of the
    main loop. Default is [true]. *)
val run:
  Window.t ->
  ?clear: (int * int * int * int) ->
  ?auto_close_window: bool ->
  (unit -> Widget.t list) -> unit
