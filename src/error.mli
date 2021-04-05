(** Error management. *)

(** SDL errors, with their message. *)
exception SDL_error of string

(** Convert SDL errors into [SDL_error] exceptions.

    Call continuation if result is [Ok]. *)
val (>>=): ('a, [< `Msg of string]) result -> ('a -> 'b) -> 'b
