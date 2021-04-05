(** Colors. *)

(** Colors.

    Colors are either RGB-encoded ([[ `rgb ] t]) or HSV-encoded ([[ `hsv ] t]).
    Additionally, the last byte is used for the alpha channel.

    Internally, colors are represented as [int32] values,
    so functions such as {!make_rgb} and {!rgb} are the identity function
    and should just be efficient. Type parameter ['a] simply prevents you
    from mixing various representations. *)
type t

(** Get the encoded version of a color.

    RGB-encoded colors are represented as [0xRRGGBBAAl].
    HSV-encoded colors are represented as [0xHHSSVVAAl]. *)
val encode: t -> int32

(** {2 Red, Green, Blue (RGB)} *)

(** Make a color from its RGB and alpha components. *)
val make_rgb: r: int -> g: int -> b: int -> a: int -> t

(** Make a color from its RGB 32-bit encoding ([0xRRGGBBAAl]). *)
val rgb: int32 -> t

(** Get the red component of a color. *)
val r: t -> int

(** Get the green component of a color. *)
val g: t -> int

(** Get the blue component of a color. *)
val b: t -> int

(** Get the alpha component of a color. *)
val a: t -> int

(** Set the red component of a color. *)
val with_r: t -> int -> t

(** Set the green component of a color. *)
val with_g: t -> int -> t

(** Set the blue component of a color. *)
val with_b: t -> int -> t

(** Set the alpha component of a color. *)
val with_a: t -> int -> t

(** {2 Hue, Saturation, Value (HSV)} *)

(** Make a color from its HSV and alpha components. *)
val hsv: h: int -> s: int -> v: int -> a: int -> t

(** {2 Common Colors} *)

val black: t
val red: t
val green: t
val blue: t
val yellow: t
val magenta: t
val cyan: t
val white: t
