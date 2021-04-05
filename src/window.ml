open Tsdl

let (>>=) x f =
  match x with
    | Error (`Msg e) ->
        Sdl.log "SDL error: %s" e;
        Sdl.quit ();
        exit 1
    | Ok x ->
        f x

type t =
  {
    mutable window: Sdl.window option;
    mutable renderer: Sdl.renderer option;
    w: int;
    h: int;
  }

let create ?(title = "Fungame") ?(w = 640) ?(h = 480) ?(vsync = true) () =
  (* Initialize SDL. *)
  Sdl.init Sdl.Init.(video + gamecontroller) >>= fun () ->
  Tsdl_ttf.Ttf.init () >>= fun () ->
  if vsync then
    if not (Sdl.set_hint Sdl.Hint.render_vsync "1") then
      Sdl.log "failed to set SDL_HINT_RENDER_VSYNC to 1";
  (* fullscreen_desktop seems broken with older versions of SDL… *)
  Sdl.create_window title ~w ~h
    Sdl.Window.(opengl(* + fullscreen_desktop *)) >>= fun window ->
  Sdl.create_renderer window >>= fun renderer ->
  Sdl.render_set_logical_size renderer w h >>= fun () ->
  {
    window = Some window;
    renderer = Some renderer;
    w;
    h;
  }

let w window =
  window.w

let h window =
  window.h

let set_renderer_draw_color renderer color =
  Sdl.set_render_draw_color renderer
    (Color.r color)
    (Color.g color)
    (Color.b color)
    (Color.a color) >>= fun () ->
  ()

let clear window color =
  match window.renderer with
    | None ->
        ()
    | Some renderer ->
        set_renderer_draw_color renderer color;
        Sdl.render_clear renderer >>= fun () ->
        ()

let draw_rect { renderer; _ } ~x ~y ~w ~h ~color ~fill =
  match renderer with
    | None ->
        ()
    | Some renderer ->
        set_renderer_draw_color renderer color;
        let render =
          if fill then
            Sdl.render_fill_rect
          else
            Sdl.render_draw_rect
        in
        let rect = Sdl.Rect.create ~x ~y ~w ~h in
        render renderer (Some rect) >>= fun () ->
        ()

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
