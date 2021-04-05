open Tsdl
open Error

type t =
  {
    id: int; (* used for memoization *)
    renderer: Sdl.renderer;
    mutable font: Tsdl_ttf.Ttf.font option;
  }

let next_id = ref 0

let load window filename size =
  Tsdl_ttf.Ttf.open_font filename size >>= fun font ->
  let id = !next_id in
  incr next_id;
  {
    id;
    renderer = Window.renderer window;
    font = Some font;
  }

let destroy font =
  match font.font with
    | None ->
        ()
    | Some f ->
        Tsdl_ttf.Ttf.close_font f;
        font.font <- None

let render ?wrap ?(color = Color.black) font text =
  let sdl_font =
    match font.font with
      | None ->
          failwith "font has been destroyed"
      | Some font ->
          font
  in
  let color =
    Sdl.Color.create
      ~r: (Color.r color)
      ~g: (Color.g color)
      ~b: (Color.b color)
      ~a: (Color.a color)
  in
  (
    match wrap with
      | None ->
          Tsdl_ttf.Ttf.render_utf8_blended sdl_font text color
      | Some width ->
          Tsdl_ttf.Ttf.render_utf8_blended_wrapped sdl_font text color
            (Int32.of_int width)
  ) >>= fun surface ->
  Sdl.create_texture_from_surface font.renderer surface >>= fun texture ->
  Sdl.free_surface surface;
  Image.from_texture font.renderer texture

module Parameters =
struct
  type t = int option * int32 * int * string
  let compare = (Stdlib.compare: t -> t -> int)
end

module Memo = Map.Make (Parameters)

(* [memo_old] contains memoized text which will be [destroy]ed at the end
   of the current frame, at which point [memo_current] will take its place. *)
let memo_old = ref Memo.empty
let memo_current = ref Memo.empty

let render_memoized ?wrap ?(color = Color.black) font text =
  let parameters = wrap, Color.encode color, font.id, text in
  match Memo.find parameters !memo_current with
    | image ->
        image
    | exception Not_found ->
        match Memo.find parameters !memo_old with
          | image ->
              (* Don't destroy this image at the end of this frame. *)
              memo_old := Memo.remove parameters !memo_old;
              memo_current := Memo.add parameters image !memo_current;
              image
          | exception Not_found ->
              let image = render ?wrap ~color font text in
              memo_current := Memo.add parameters image !memo_current;
              image

let next_frame () =
  Memo.iter (fun _ -> Image.destroy) !memo_old;
  memo_old := !memo_current;
  memo_current := Memo.empty

let clear_memo () =
  (* clear [memo_old] *)
  next_frame ();
  (* clear [memo_current] *)
  next_frame ()
