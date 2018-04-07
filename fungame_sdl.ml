open Tsdl

let (>>=) x f =
  match x with
    | Error (`Msg e) ->
        Printf.printf "SDL error: %s" e;
        Sdl.log "SDL error: %s" e;
        Sdl.quit ();
        exit 1
    | Ok x ->
        f x

let renderer = ref None

let set_renderer x =
  renderer := Some x

let get_renderer () =
  match !renderer with
    | None ->
        failwith "get_renderer: SDL is not initialized"
    | Some x ->
        x

module Image =
struct
  type image =
    | To_load of string
    | Loaded of Sdl.texture * int * int

  type t = image ref

  let width image =
    match !image with
      | To_load _ -> 0
      | Loaded (_, w, _) -> w

  let height image =
    match !image with
      | To_load _ -> 0
      | Loaded (_, _, h) -> h

  let load filename =
    if Sys.file_exists filename then
      ref (To_load filename)
    else
      failwith ("no such file: " ^ filename)

  let draw ~src_x ~src_y ~w ~h ~x ~y image =
    let renderer = get_renderer () in
    let texture, image_w, image_h =
      match !image with
        | To_load filename ->
            Tsdl_image.Image.load_texture renderer filename >>= fun texture ->
            Sdl.query_texture texture >>= fun (_, _, (w, h)) ->
            image := Loaded (texture, w, h);
            texture, w, h
        | Loaded (texture, image_w, image_h) ->
            texture, image_w, image_h
    in
    let w = min w image_w in
    let h = min h image_h in
    let src = Sdl.Rect.create 0 0 w h in
    let dst = Sdl.Rect.create x y w h in
    Sdl.render_copy ~src ~dst renderer texture >>= fun () ->
    ()

  let draw_rect ~x ~y ~w ~h ~color ~fill =
    let renderer = get_renderer () in
    let r, g, b, a = color in
    Sdl.set_render_draw_color renderer r g b a >>= fun () ->
    let render =
      if fill then
        Sdl.render_fill_rect
      else
        Sdl.render_draw_rect
    in
    let rect = Sdl.Rect.create x y w h in
    render renderer (Some rect) >>= fun () ->
    ()
end

module Widget = Widget.Make (Image)

exception Quit

let quit () =
  raise Quit

let run ?(title = "Fungame") ?(w = 640) ?(h = 480) ?clear make_ui =
  (* Initialize SDL. *)
  Sdl.init Sdl.Init.video >>= fun () ->
  (* fullscreen_desktop seems broken with older versions of SDL… *)
  Sdl.create_window title ~w ~h
    Sdl.Window.(opengl (* + fullscreen_desktop *)) >>= fun window ->
  Sdl.create_renderer window >>= fun renderer ->
  set_renderer renderer;
  Sdl.render_set_logical_size renderer w h >>= fun () ->

  let widget_state = Widget.start () in

  try
    while true do
      (
        match clear with
          | None ->
              ()
          | Some (r, g, b, a) ->
              Sdl.set_render_draw_color renderer r g b a >>= fun () ->
              Sdl.render_clear renderer >>= fun () ->
              ()
      );

      let widget = Widget.place w h (Widget.box (make_ui ())) in
      Widget.draw ~x: 0 ~y: 0 widget;

      Sdl.render_present renderer;

      Sdl.delay 1l;

      let event = Sdl.Event.create () in

      while Sdl.poll_event (Some event) do
        let typ = Sdl.Event.get event Sdl.Event.typ in

        if typ = Sdl.Event.quit then
          quit ()

        else if typ = Sdl.Event.key_down then
          let scancode = Sdl.Event.get event Sdl.Event.keyboard_scancode in
          if scancode = Sdl.Scancode.escape then
            quit ()
          else
            ()

        else if typ = Sdl.Event.mouse_button_down then
          let x = Sdl.Event.get event Sdl.Event.mouse_button_x in
          let y = Sdl.Event.get event Sdl.Event.mouse_button_y in
          let button = Sdl.Event.get event Sdl.Event.mouse_button_button in
          let _: bool = Widget.mouse_down widget_state ~button ~x ~y widget in
          ()

        else if typ = Sdl.Event.mouse_button_up then
          let x = Sdl.Event.get event Sdl.Event.mouse_button_x in
          let y = Sdl.Event.get event Sdl.Event.mouse_button_y in
          let button = Sdl.Event.get event Sdl.Event.mouse_button_button in
          let _: bool = Widget.mouse_up widget_state ~button ~x ~y widget in
          ()

        else if typ = Sdl.Event.mouse_motion then
          let x = Sdl.Event.get event Sdl.Event.mouse_motion_x in
          let y = Sdl.Event.get event Sdl.Event.mouse_motion_y in
          let _: bool = Widget.mouse_move widget_state ~x ~y widget in
          ()

      done
    done
  with Quit ->
    Sdl.destroy_window window;
    Sdl.quit ()
