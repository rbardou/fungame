(** Gamepad buttons. *)

(** Analogic sticks and triggers. *)
type axis =
  | Left_x
  | Left_y
  | Right_x
  | Right_y
  | Left_trigger
  | Right_trigger
  | Other of int

(** Boolean (up or down) buttons. *)
type button =
  | A
  | B
  | X
  | Y
  | Back
  | Guide
  | Start
  | Left_stick
  | Right_stick
  | Left_shoulder
  | Right_shoulder
  | Dpad_up
  | Dpad_down
  | Dpad_left
  | Dpad_right
  | Other of int
