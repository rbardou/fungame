(** Sound. *)

(** Sounds. *)
type t

(** Open audio output.

    Automatically called by [load].

    Default value for [channel_count] is 64. This is the maximum number of sounds
    that can be played at the same time. *)
val init: ?channel_count: int -> unit -> unit

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
