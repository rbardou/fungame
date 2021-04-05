let (>>) = Int32.shift_right_logical
let (<<) = Int32.shift_left
let low_byte x = Int32.logand x 0xFFl |> Int32.to_int
let fix x = Int32.of_int (max 0 (min 255 x))
let (&&&) = Int32.logand
let (|||) = Int32.logor

type t = int32

let encode x = x

let make_rgb ~r ~g ~b ~a = (fix r << 24) ||| (fix g << 16) ||| (fix b << 8) ||| fix a
let rgb x = x
let r color = low_byte (color >> 24)
let g color = low_byte (color >> 16)
let b color = low_byte (color >> 8)
let a color = low_byte color
let with_r color x = (color &&& 0x00FFFFFFl) ||| (fix x << 24)
let with_g color x = (color &&& 0xFF00FFFFl) ||| (fix x << 16)
let with_b color x = (color &&& 0xFFFF00FFl) ||| (fix x << 8)
let with_a color x = (color &&& 0xFFFFFF00l) ||| (fix x)

let hsv ~h ~s ~v ~a =
  (* Adjust input. *)
  let h = h mod 360 in
  let h = if h < 0 then h + 360 else h in
  let s = max 0 (min 100 s) in
  let v = max 0 (min 100 v) in
  (* Compute values. *)
  let c = v * s in (* chroma, from 0 to 10000 *)
  let x = c * (60 - abs (h mod 120 - 60)) in (* from 0 to 60000 *)
  let m = v * 100 - c in
  (* Adjust scale. *)
  let c = c * 255 / 10000 in
  let x = x * 255 / 600000 in
  let m = m * 255 / 10000 in
  (* Choose depending on hue. *)
  let r, g, b =
    if h < 60 then c + m, x + m, m else
    if h < 120 then x + m, c + m, m else
    if h < 180 then m, c + m, x + m else
    if h < 240 then m, x + m, c + m else
    if h < 300 then x + m, m, c + m else
      c + m, m, x + m
  in
  Int32.logor (Int32.of_int r << 24) @@
  Int32.logor (Int32.of_int g << 16) @@
  Int32.logor (Int32.of_int b << 8) @@
  Int32.of_int a

let black = 0x000000FFl
let red = 0xFF0000FFl
let green = 0x00FF00FFl
let blue = 0x0000FFFFl
let yellow = 0xFFFF00FFl
let magenta = 0xFF00FFFFl
let cyan = 0x00FFFFFFl
let white = 0xFFFFFFFFl
