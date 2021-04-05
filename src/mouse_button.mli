(** Mouse buttons. *)

(** Mouse buttons. *)
type t =
  | Left
  | Middle
  | Right
  | Other of int

(** Convert a mouse button to its constructor name. *)
val show: t -> string

(** Compare two mouse buttons. *)
val compare: t -> t -> int
