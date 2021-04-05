(** Boxes that contain other widgets and that can be scrolled. *)

(** Create a vertical scroll box.

    Widgets in the scroll box are given infinite vertical space.
    The box itself takes the available space or less.
    Its contents can be scrolled vertically using the mouse wheel. *)
val create_vertical: Layout.t -> Widget.t
