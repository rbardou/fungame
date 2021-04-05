open Tsdl
open Error

type t =
  {
    renderer: Sdl.renderer;
    mutable texture: Sdl.texture option;
    w: int;
    h: int;
    hot_x: int;
    hot_y: int;
  }

let w image = image.w
let h image = image.h
let hot_x image = image.hot_x
let hot_y image = image.hot_y

let from_texture ?(hot_x = 0) ?(hot_y = 0) renderer texture =
  Sdl.query_texture texture >>= fun (_, _, (w, h)) ->
  {
    renderer;
    texture = Some texture;
    w;
    h;
    hot_x;
    hot_y;
  }

let load ?hot_x ?hot_y (window: Window.t) filename =
  if not (Sys.file_exists filename) then
    failwith ("no such file: " ^ filename);
  let renderer = Window.renderer window in
  Tsdl_image.Image.load_texture renderer filename >>= fun texture ->
  from_texture ?hot_x ?hot_y renderer texture

let load_as_matrix filename =
  if not (Sys.file_exists filename) then
    failwith ("no such file: " ^ filename);
  Tsdl_image.Image.load filename >>= fun surface ->
  Sdl.lock_surface surface >>= fun () ->
  let pixels = Sdl.get_surface_pixels surface Bigarray.Int32 in
  Sdl.unlock_surface surface;
  let w, h = Sdl.get_surface_size surface in
  w, h,
  Array.init w @@ fun x ->
  Array.init h @@ fun y ->
  (* TODO: convert color depending on surface format *)
  Color.rgb (Bigarray.Array1.get pixels (y * w + x))

let make ?hot_x ?hot_y ~w ~h (window: Window.t) make_pixel =
  let renderer = Window.renderer window in
  Sdl.create_rgb_surface ~w ~h ~depth: 32 0xff000000l 0x00ff0000l 0x0000ff00l 0x000000ffl
  >>= fun surface ->
  Sdl.lock_surface surface >>= fun () ->
  let pixels = Sdl.get_surface_pixels surface Bigarray.Int32 in
  for i = 0 to w * h - 1 do
    let color = make_pixel (i mod w) (i / w) in
    Bigarray.Array1.set pixels i (Color.encode color)
  done;
  Sdl.unlock_surface surface;
  Sdl.create_texture_from_surface renderer surface >>= fun texture ->
  from_texture ?hot_x ?hot_y renderer texture

let destroy image =
  match image.texture with
    | None ->
        ()
    | Some texture ->
        Sdl.destroy_texture texture;
        image.texture <- None

let draw ?(src_x = 0) ?(src_y = 0) ?w ?h ?(x = 0) ?(y = 0) ?dst_w ?dst_h ?(alpha=255) ?angle
    image =
  let x = x - image.hot_x in
  let y = y - image.hot_y in
  let w = match w with None -> image.w - src_x | Some w -> w in
  let h = match h with None -> image.h - src_y | Some h -> h in
  if w > 0 && h > 0 then
    match image.texture with
      | None ->
          failwith "image has been destroyed"
      | Some texture ->
          let w = min w image.w in
          let h = min h image.h in
          let dst_w = match dst_w with None -> w | Some w -> w in
          let dst_h = match dst_h with None -> h | Some h -> h in
          let src = Sdl.Rect.create ~x: src_x ~y: src_y ~w ~h in
          let dst = Sdl.Rect.create ~x ~y ~w: dst_w ~h: dst_h in
          let _ = Sdl.set_texture_alpha_mod texture alpha in
          (match angle with
            | None ->
                Sdl.render_copy ~src ~dst image.renderer texture
            | Some angle ->
                Sdl.render_copy_ex ~src ~dst image.renderer texture angle
                  (Some (Sdl.Point.create ~x: image.hot_x ~y: image.hot_y))
                  Sdl.Flip.none)
          >>= fun () -> ()
