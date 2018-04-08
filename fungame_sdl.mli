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

(** {2 Images} *)

module Image:
sig
  include Widget.IMAGE

  (** Load an image from a file. *)
  val load: Window.t -> string -> t

  (** Free an image. *)
  val destroy: t -> unit

  (** Get the width of an image. *)
  val width: t -> int

  (** Get the height of an image. *)
  val height: t -> int
end

(** {2 Fonts} *)

module Font:
sig
  type t

  (** Load a font from a file, given a requested font size. *)
  val load: Window.t -> string -> int -> t

  (** Free a font. *)
  val destroy: t -> unit

  (** How to render text.

      [Solid] is fast to render and to draw, but it is ugly.

      [Shaded] is slower to render but as fast as [Solid] to draw.
      It is as pretty as [Blended] but the resulting image is not transparent.
      The arguments are the background color (red, green, blue, alpha).

      [Blended] is as slow to render as [Shaded] and the image is transparent,
      so it is the best mode to draw on top of other images.

      [Wrapped width] is the same as [Blended], except that the text is split
      into several lines if it is larger than [width]. *)
  type mode =
    | Solid
    | Shaded of int * int * int * int
    | Blended
    | Wrapped of int

  (** Render some text.

      If [utf8] is [true], assume the input string is UTF8-encoded.
      Otherwise, assume the input string is LATIN1-encoded.
      Default is [true].

      Default [mode] is [Blended].

      Default [color] is black ([0, 0, 0, 255]). *)
  val render:
    ?utf8: bool ->
    ?mode: mode ->
    ?color: (int * int * int * int) ->
    t -> string -> Image.t
end

(** {2 Sounds} *)

module Sound:
sig
  type t

  (** Open audio output.

      Automatically called by [load]. *)
  val init: unit -> unit

  (** Close audio output.

      Has no effect if audio is not open. *)
  val close: unit -> unit

  (** Load a WAV file. *)
  val load: string -> t

  (** Free a sound. *)
  val destroy: t -> unit

  (** Play a sound.

      Sound will be played [loops + 1] times.
      Default value for [loops] is [0]. *)
  val play: ?loops: int -> t -> unit
end

(** {2 Widgets} *)

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
    main loop. Default is [true].

    If [auto_close_sound] is [true], call [Sound.close] at the end of the
    main loop. Default is [true]. *)
val run:
  Window.t ->
  ?clear: (int * int * int * int) ->
  ?auto_close_window: bool ->
  ?auto_close_sound: bool ->
  (unit -> Widget.t list) -> unit
