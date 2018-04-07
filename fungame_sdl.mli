(** Simple library to make games using SDL. *)

(** This library handles inputs and outputs.
    It provides widgets that you can combine to describe both how to draw
    your game and how inputs (especially mouse inputs) are interpreted. *)

(** {2 Images *)

module Image:
sig
  include Widget.IMAGE
  val load: string -> t
end

(** {2 Widgets *)

module Widget: Widget.WIDGET with type image = Image.t

(** {2 Main Loop} *)

(** Run the game.

    Usage: [run make_ui]

    Call [make_ui] to build a widget list, then draw it and handle
    events. Then call [make_ui] again and start over, looping until
    the user exits.

    If [clear] is specified, clear screen using given color before drawing. *)
val run:
  ?title: string ->
  ?w: int -> ?h: int ->
  ?clear: (int * int * int * int) ->
  (unit -> Widget.t list) -> unit
