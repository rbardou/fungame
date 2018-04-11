module type S =
sig
  (** Signature of main Fungame modules. *)

  (** {2 Windows} *)

  module Window:
  sig
    type t

    (** Create a new window.

        Default title is ["Fungame"].
        Default size is [640 * 480].

        Note that multiple windows are not really supported. *)
    val create: ?title: string -> ?w: int -> ?h: int -> unit -> t
  end

  (** {2 Keys} *)

  module Scan_code = Fungame_scan_code
  module Key_code = Fungame_key_code

  module Key:
  sig
    type t

    (** Show the key code of a key. *)
    val show: t -> string

    (** Show the scan code of a key. *)
    val show_scan_code: t -> string

    (** Get the scan code of a key. *)
    val scan_code: t -> Scan_code.t

    (** Get the key code of a key. *)
    val key_code: t -> Key_code.t

    (** Make a key from a scan code. *)
    val of_scan_code: Scan_code.t -> t

    (** Make a key from a key code. *)
    val of_key_code: Key_code.t -> t

    (** Return whether a key is being pressed. *)
    val is_down: t -> bool
  end

  (** {2 Images} *)

  module Image:
  sig
    include Fungame_widget.IMAGE

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

    (** Same as [render], but memoize the result.

        If you call [render_memoized] in the next frame with the same
        parameters, the image will be reused, saving the rendering
        time. If you don't, or if the main loop ends, the image will
        be [destroy]ed automatically.

        This allows you to render text on the fly instead of at the beginning
        and yet not lose much performance. This is especially convenient
        for text containing values which depend on the state of your program.

        Instead of calling [render_memoized] directly, you probably want to
        use [Widget.text]. *)
    val render_memoized:
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

  module Widget:
  sig
    include Fungame_widget.WIDGET with type image = Image.t

    val text:
      ?utf8: bool ->
      ?mode: Font.mode ->
      ?color: (int * int * int * int) ->
      Font.t -> string -> t
  end

  (** {2 Main Loop} *)

  module Main_loop:
  sig
    (** Main loop which handles input events and video output. *)

    (** Run the game.

        Usage: [run make_ui]

        Call [make_ui] to build a widget list, then draw it and handle
        events. Then call [make_ui] again and start over, looping until
        the user exits.

        If [clear] is specified, clear screen using given color before drawing.

        If [auto_close_window] is [true], call [Window.close] at the end of the
        main loop. Default is [true].

        If [auto_close_sound] is [true], call [Sound.close] at the end of the
        main loop. Default is [true].

        If [fps] is specified, add a delay after each iteration to try to
        maintain a framerate of [fps] frames per second. Drop frames if
        necessary, but not too many consecutively.

        If [update] is specified, call it after each iteration with the number
        of milliseconds elapsed since the last time it was called. *)
    val run:
      Window.t ->
      ?clear: (int * int * int * int) ->
      ?auto_close_window: bool ->
      ?auto_close_sound: bool ->
      ?on_key_down: (Key.t -> unit) ->
      ?on_key_repeat: (Key.t -> unit) ->
      ?on_key_up: (Key.t -> unit) ->
      ?fps: int ->
      ?update: (int -> unit) ->
      (unit -> Widget.t list) -> unit

    (** Exit the main loop.

        Call this from event handlers or from [update]. *)
    val quit: unit -> unit
  end
end
