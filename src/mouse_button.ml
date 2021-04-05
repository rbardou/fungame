type t =
  | Left
  | Middle
  | Right
  | Other of int

let show = function
  | Left -> "Left"
  | Middle -> "Middle"
  | Right -> "Right"
  | Other i -> "Button" ^ string_of_int i

let compare = Stdlib.compare
