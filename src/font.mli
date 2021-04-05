(** Fonts. *)

(** Fonts. *)
type t

(** Load a font from a file, given a requested font size. *)
val load: Window.t -> string -> int -> t

(** Free a font. *)
val destroy: t -> unit

(** Render some text.

    If [wrap] is specified, split text into several lines at word
    boundaries so that the result is no larger than [width] if possible.

    Default [color] is black ([0, 0, 0, 255]). *)
val render:
  ?wrap: int ->
  ?color: Color.t ->
  t -> string -> Image.t

(** Same as [render], but memoize the result.

    If you call [render_memoized] in the next frame with the same
    parameters, the image will be reused, saving the rendering
    time. If you don't, or if the main loop ends, the image will
    be [destroy]ed automatically.

    This allows you to render text on the fly instead of at the beginning
    and yet not lose much performance. This is especially convenient
    for text containing values which depend on the state of your program. *)
val render_memoized:
  ?wrap: int ->
  ?color: Color.t ->
  t -> string -> Image.t

(** Destroy memoized texts that were not used since the last call to [next_frame].

    Automatically called by [Main.run]. *)
val next_frame: unit -> unit

(** Destroy all memoized texts. *)
val clear_memo: unit -> unit
