(** Text widgets. *)

(** Create a widget that contains text.

    The widget automatically takes the dimensions of the text.

    If [wrap] is true, text wraps using available width. *)
val create: ?color: Color.t -> ?wrap: bool -> Font.t -> string -> Widget.t
