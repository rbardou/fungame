(** Images. *)

(** Images. *)
type t

(** Draw an image. *)
val draw:
  ?src_x: int -> ?src_y: int -> ?w: int -> ?h: int -> ?x: int -> ?y: int ->
  ?dst_w: int -> ?dst_h: int -> ?alpha: int -> ?angle: float -> t -> unit

(** Load an image from a file. *)
val load: ?hot_x: int -> ?hot_y: int -> Window.t -> string -> t

(** Load an image from a file as a matrix. *)
val load_as_matrix: string -> int * int * Color.t array array

(** Make an image from an function which returns the color of each pixel.

    Not that this function is optimized for convenience, not efficiency.
    I.e. you should use it for testing purposes only. *)
val make: ?hot_x: int -> ?hot_y: int -> w: int -> h: int -> Window.t ->
  (int -> int -> Color.t) -> t

(** Free an image. *)
val destroy: t -> unit

(** Get the width of an image. *)
val w: t -> int

(** Get the height of an image. *)
val h: t -> int

(** Get the X coordinate of the hotspot of an image. *)
val hot_x: t -> int

(** Get the Y coordinate of the hotspot of an image. *)
val hot_y: t -> int

(** Make an image from a SDL texture. *)
val from_texture: ?hot_x: int -> ?hot_y: int -> Tsdl.Sdl.renderer -> Tsdl.Sdl.texture -> t
