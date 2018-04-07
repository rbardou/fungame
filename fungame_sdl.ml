open Tsdl

let (>>=) x f =
  match x with
    | Error (`Msg e) ->
        Sdl.log "SDL error: %s" e;
        Sdl.quit ();
        exit 1
    | Ok x ->
        f x

module Window =
struct
  type t =
    {
      mutable window: Sdl.window option;
      mutable renderer: Sdl.renderer option;
      w: int;
      h: int;
    }

  let create ?(title = "Fungame") ?(w = 640) ?(h = 480) () =
    (* Initialize SDL. *)
    Sdl.init Sdl.Init.video >>= fun () ->
    Tsdl_ttf.Ttf.init () >>= fun () ->
    (* fullscreen_desktop seems broken with older versions of SDL… *)
    Sdl.create_window title ~w ~h
      Sdl.Window.(opengl (* + fullscreen_desktop *)) >>= fun window ->
    Sdl.create_renderer window >>= fun renderer ->
    Sdl.render_set_logical_size renderer w h >>= fun () ->
    {
      window = Some window;
      renderer = Some renderer;
      w;
      h;
    }

  let close window =
    (
      match window.window with
        | None ->
            ()
        | Some w ->
            Sdl.destroy_window w;
            window.window <- None
    );
    (
      match window.renderer with
        | None ->
            ()
        | Some r ->
            Sdl.destroy_renderer r;
            window.renderer <- None
    )

  let renderer window =
    match window.renderer with
      | None ->
          failwith "window has been closed"
      | Some renderer ->
          renderer

end

module Image =
struct
  type t =
    {
      window: Window.t;
      mutable texture: Sdl.texture option;
      w: int;
      h: int;
    }

  let width image = image.w
  let height image = image.h

  let from_texture window texture =
    Sdl.query_texture texture >>= fun (_, _, (w, h)) ->
    {
      window;
      texture = Some texture;
      w;
      h;
    }

  let load (window: Window.t) filename =
    if not (Sys.file_exists filename) then
      failwith ("no such file: " ^ filename);
    let renderer = Window.renderer window in
    Tsdl_image.Image.load_texture renderer filename >>= fun texture ->
    from_texture window texture

  let destroy image =
    match image.texture with
      | None ->
          ()
      | Some texture ->
          Sdl.destroy_texture texture;
          image.texture <- None

  let draw ~src_x ~src_y ~w ~h ~x ~y image =
    match image.texture with
      | None ->
          failwith "image has been destroyed"
      | Some texture ->
          let renderer = Window.renderer image.window in
          let w = min w image.w in
          let h = min h image.h in
          let src = Sdl.Rect.create 0 0 w h in
          let dst = Sdl.Rect.create x y w h in
          Sdl.render_copy ~src ~dst renderer texture >>= fun () ->
          ()
end

module Font =
struct
  type t =
    {
      window: Window.t;
      mutable font: Tsdl_ttf.Ttf.font option;
    }

  let load window filename size =
    Tsdl_ttf.Ttf.open_font filename size >>= fun font ->
    {
      window;
      font = Some font;
    }

  let destroy font =
    match font.font with
      | None ->
          ()
      | Some f ->
          Tsdl_ttf.Ttf.close_font f;
          font.font <- None

  type mode =
    | Solid
    | Shaded of int * int * int * int
    | Blended
    | Wrapped of int

  let render ?(utf8 = true) ?(mode = Blended) ?(color = (0, 0, 0, 255))
      font text =
    let window = font.window in
    let renderer = Window.renderer window in
    let font =
      match font.font with
        | None ->
            failwith "font has been destroyed"
        | Some font ->
            font
    in
    let color =
      let r, g, b, a = color in
      Sdl.Color.create ~r ~g ~b ~a
    in
    (
      match utf8, mode with
        | false, Solid ->
            Tsdl_ttf.Ttf.render_text_solid font text color
        | true, Solid ->
            Tsdl_ttf.Ttf.render_utf8_solid font text color
        | false, Shaded (r, g, b, a) ->
            let bg_color = Sdl.Color.create ~r ~g ~b ~a in
            Tsdl_ttf.Ttf.render_text_shaded font text color bg_color
        | true, Shaded (r, g, b, a) ->
            let bg_color = Sdl.Color.create ~r ~g ~b ~a in
            Tsdl_ttf.Ttf.render_utf8_shaded font text color bg_color
        | false, Blended ->
            Tsdl_ttf.Ttf.render_text_blended font text color
        | true, Blended ->
            Tsdl_ttf.Ttf.render_utf8_blended font text color
        | false, Wrapped width ->
            Tsdl_ttf.Ttf.render_text_blended_wrapped font text color
              (Int32.of_int width)
        | true, Wrapped width ->
            Tsdl_ttf.Ttf.render_utf8_blended_wrapped font text color
              (Int32.of_int width)
    ) >>= fun surface ->
    Sdl.create_texture_from_surface renderer surface >>= fun texture ->
    Sdl.free_surface surface;
    Image.from_texture window texture

end

module Widget = Widget.Make (Image)

exception Quit

let quit () =
  raise Quit

let draw_rect renderer ~x ~y ~w ~h ~color ~fill =
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

let run window ?clear ?(auto_close_window = true) make_ui =
  let widget_state = Widget.start () in
  let renderer = Window.renderer window in
  let { w; h }: Window.t = window in

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
      Widget.draw (draw_rect renderer) ~x: 0 ~y: 0 widget;

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
    if auto_close_window then Window.close window;
    Sdl.quit ()
