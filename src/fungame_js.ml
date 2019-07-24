let alert x = Dom_html.window##alert(Js.string x)
let log x = Firebug.console##log(Js.string x)
let error x = Firebug.console##error(Js.string x)

let make_color (r, g, b, a) =
  Printf.sprintf "#%02x%02x%02x" r g b |> Js.string

module Window =
struct
  type context = Dom_html.canvasRenderingContext2D Js.t

  type t =
    {
      w: int;
      h: int;
      mutable context: context option;
    }

  let create ?(title = "Fungame") ?(w = 640) ?(h = 480) () =
    (* TODO: title *)
    {
      w;
      h;
      context = None; (* filled by [run] in [on_load] *)
    }

  let close window =
    window.context <- None
end

module Scan_code = Fungame_scan_code
module Key_code = Fungame_key_code

module Scan_code_set = Set.Make (Scan_code)

module Int_string_pair =
struct
  type t = int * string
  let compare = (Pervasives.compare: t -> t -> int)
end

module Int_string_pair_map = Map.Make (Int_string_pair)
module Scan_code_map = Map.Make (Scan_code)
module Key_code_map = Map.Make (Key_code)

module Key =
struct
  type t =
    {
      scan_code: Scan_code.t;
      key_code: Key_code.t;
    }

  let show key =
    Key_code.show key.key_code

  let show_scan_code key =
    Scan_code.show key.scan_code

  let scan_code key =
    key.scan_code

  let key_code key =
    key.key_code

  (* Note: "Alt", 2 seems to be "AltGraph", 0 instead *)
  let list =
    (* key, location, scan code, key code *)
    [
      "a", 0, (A: Scan_code.t), (A: Key_code.t);
      "b", 0, B, B;
      "c", 0, C, C;
      "d", 0, D, D;
      "e", 0, E, E;
      "f", 0, F, F;
      "g", 0, G, G;
      "h", 0, H, H;
      "i", 0, I, I;
      "j", 0, J, J;
      "k", 0, K, K;
      "l", 0, L, L;
      "m", 0, M, M;
      "n", 0, N, N;
      "o", 0, O, O;
      "p", 0, P, P;
      "q", 0, Q, Q;
      "r", 0, R, R;
      "s", 0, S, S;
      "t", 0, T, T;
      "u", 0, U, U;
      "v", 0, V, V;
      "w", 0, W, W;
      "x", 0, X, X;
      "y", 0, Y, Y;
      "z", 0, Z, Z;
      " ", 0, Space, Space;
      "Enter", 0, Return, Return;
      "Backspace", 0, Backspace, Backspace;
      "Tab", 0, Tab, Tab;
      "Shift", 1, Lshift, Lshift;
      "Shift", 2, Rshift, Rshift;
      "Control", 1, Lctrl, Lctrl;
      "Control", 2, Rctrl, Rctrl;
      "Alt", 1, Lalt, Lalt;
      "Alt", 2, Ralt, Ralt;
      "AltGraph", 0, Ralt, Ralt;
      "ArrowLeft", 0, Left, Left;
      "ArrowRight", 0, Right, Right;
      "ArrowUp", 0, Up, Up;
      "ArrowDown", 0, Down, Down;
      "F1", 0, F1, F1;
      "F2", 0, F2, F2;
      "F3", 0, F3, F3;
      "F4", 0, F4, F4;
      "F5", 0, F5, F5;
      "F6", 0, F6, F6;
      "F7", 0, F7, F7;
      "F8", 0, F8, F8;
      "F9", 0, F9, F9;
      "F10", 0, F10, F10;
      "F11", 0, F11, F11;
      "F12", 0, F12, F12;
      "Escape", 0, Escape, Escape;
    ]

  let js_to_key =
    let add acc (name, location, scan_code, key_code) =
      Int_string_pair_map.add (location, name) { scan_code; key_code } acc
    in
    List.fold_left add Int_string_pair_map.empty list

  let scan_code_to_key =
    let add acc (_, _, scan_code, key_code) =
      Scan_code_map.add scan_code { scan_code; key_code } acc
    in
    List.fold_left add Scan_code_map.empty list

  let key_code_to_key =
    let add acc (_, _, scan_code, key_code) =
      Key_code_map.add key_code { scan_code; key_code } acc
    in
    List.fold_left add Key_code_map.empty list

  let of_js name location =
    match Int_string_pair_map.find (location, name) js_to_key with
      | exception Not_found -> { scan_code = Unknown; key_code = Unknown }
      | key -> key

  let of_scan_code (scan_code: Scan_code.t) =
    match Scan_code_map.find scan_code scan_code_to_key with
      | exception Not_found -> { scan_code = Unknown; key_code = Unknown }
      | key -> key

  let of_key_code (key_code: Key_code.t) =
    match Key_code_map.find key_code key_code_to_key with
      | exception Not_found -> { scan_code = Unknown; key_code = Unknown }
      | key -> key

  let pressed = ref Scan_code_set.empty

  let is_down key =
    Scan_code_set.mem key.scan_code !pressed
end

module Image =
struct
  type renderer =
    | Empty
    | Image of Dom_html.imageElement Js.t
    | Text of Js.js_string Js.t * Js.js_string Js.t * (int * int * int * int)

  (* Size is computed when rendering, maybe it has more chance
     of being loaded then? *)
  type t =
    {
      mutable w: int option;
      mutable h: int option;
      window: Window.t;
      mutable renderer: renderer;
    }

  let load (window: Window.t) filename =
    let image = Dom_html.(createImg document) in
    image##src <- Js.string filename;
    {
      w = None;
      h = None;
      window;
      renderer = Image image;
    }

  let destroy image =
    image.renderer <- Empty

  let width image =
    match image.w with
      | None -> 64
      | Some w -> w

  let height image =
    match image.h with
      | None -> 64
      | Some h -> h

  let measure_text (context: Window.context) text =
    let metrics = context##measureText(text) in
    let w = int_of_float metrics##width in
    (* JS does not provide an easy way to measure height.
       For now, we use a hack by estimating the height from the width of one large character.
       TODO: improve this *)
    let metrics = context##measureText(Js.string "W") in
    let h = int_of_float metrics##width in
    w, h

  let draw ~src_x ~src_y ~w ~h ~x ~y image =
    match image.renderer, image.window.context with
      | Empty, _ | _, None ->
          ()
      | Image img, Some context ->
          let w = float w in
          let h = float h in
          (
            try
              context##drawImage_full(
                img,
                float src_x, float src_y, w, h,
                float x, float y, w, h
              );
              (* If we are still here we should have the size. *)
              (
                match image.w with
                  | None ->
                      image.w <- Some img##width
                  | Some _ ->
                      ()
              );
              (
                match image.h with
                  | None ->
                      image.h <- Some img##height
                  | Some _ ->
                      ()
              );
            with exn ->
              let message =
                match exn with
                  | Failure message ->
                      message
                  | exn ->
                      Printexc.to_string exn
              in
              error ("Failed to draw image: " ^ Js.to_string img##src ^ ": " ^ message)
          )
      | Text (text, font_name, color), Some context ->
          (* TODO: support clipping with [src_x], [src_y], [w] and [h] *)
          context##font <- font_name;
          context##fillStyle <- make_color color;
          let y_offset =
            (* Unlike SDL, JS uses the baseline or something like that to draw text.
               But js_of_ocaml does not seem to provide advanced text metrics
               (which are not supported by browsers yet anyway?).
               So here is another ugly hack for now... *)
            (* TODO: improve this *)
            match image.h with
              | None ->
                  let w, h = measure_text context text in
                  image.w <- Some w;
                  image.h <- Some h;
                  h * 8 / 10
              | Some h ->
                  h * 8 / 10
          in
          context##fillText(text, float x, float (y + y_offset));
end

module Font =
struct
  type t =
    {
      window: Window.t;
      name: Js.js_string Js.t;
    }

  let load (window: Window.t) filename size =
    (* TODO: use [filename] somehow, but we may need a @font-face in a CSS style sheet. *)
    let name = Js.string (string_of_int size ^ "px sans-serif") in
    { window; name }

  let destroy font =
    ()

  let render ?wrap ?(color = (0, 0, 0, 255)) font text =
    let text = Js.string text in
    let w, h =
      match font.window.context with
        | None ->
            None, None
        | Some context ->
            context##font <- font.name;
            let w, h = Image.measure_text context text in
            Some w, Some h
    in
    {
      Image.w;
      h;
      window = font.window;
      renderer = Text (text, font.name, color);
    }

  let render_memoized ?wrap ?(color = (0, 0, 0, 255)) font text =
    render ?wrap ~color font text (* TODO *)
end

module Sound =
struct
  (* TODO: audio cannot play itself more than once simultaneously,
     do we want to create several audio and cycle? *)
  type t = { mutable audio: Dom_html.audioElement Js.t option }

  let init () = ()
  let close () = ()

  let load filename =
    let audio = Dom_html.createAudio Dom_html.document in
    audio##src <- Js.string filename;
    { audio = Some audio }

  let destroy sound =
    sound.audio <- None

  let play ?(loops = 0) sound =
    (* TODO: loops *)
    match sound.audio with
      | None ->
          ()
      | Some audio ->
          audio##play()
end

module Widget =
struct
  include Fungame_widget.Make (Image)

  let text ?wrap ?color font text =
    image (Font.render_memoized ?wrap ?color font text)
end

module Main_loop =
struct

  exception Quit

  let continue = ref true

  let quit () =
    continue := false

  let run (window: Window.t)
      ?clear
      ?(auto_close_window = true)
      ?(auto_close_sound = true) (* TODO *)
      ?(on_key_down = fun _ -> ())
      ?(on_key_repeat = fun _ -> ()) (* TODO *)
      ?(on_key_up = fun _ -> ())
      ?fps (* TODO *)
      ?(update = fun _ -> ())
      make_ui =

    let widget_state = Widget.start () in
    let widget = ref (Widget.place 0 0 (Widget.box [])) in
    let last_frame_time = ref 0. in

    let capture_event event event_was_used =
      (
        if event_was_used then
          Dom_html.stopPropagation event;
      );
      (* Js._false would prevent default action. *)
      Js._true
    in

    let on_mouse_move (event: Dom_html.mouseEvent Js.t) =
      let x = event##clientX in
      let y = event##clientY in
      Widget.mouse_move widget_state ~x ~y !widget
      |> capture_event event
    in

    let on_mouse_down (event: Dom_html.mouseEvent Js.t) =
      (* Left button is button 0 in Javascript whereas in SDL it is 1. *)
      (* Middle button is button 1 in Javascript whereas in SDL it is 2. *)
      (* Right button is button 2 in Javascript whereas in SDL it is 3. *)
      let button = event##button + 1 in
      let x = event##clientX in
      let y = event##clientY in
      Widget.mouse_down widget_state ~button ~x ~y !widget
      |> capture_event event
    in

    let on_mouse_up (event: Dom_html.mouseEvent Js.t) =
      let button = event##button + 1 in
      let x = event##clientX in
      let y = event##clientY in
      Widget.mouse_up widget_state ~button ~x ~y !widget
      |> capture_event event
    in

    let key_of_event (event: Dom_html.keyboardEvent Js.t) =
      (* According to my tests with FireFox 52.7.3:
         - [key] contains something like "a", "b", "é", "Enter"...
         - [char_code] contains 0
         - [key_identifier] contains null
         - [key_code] contains the ASCII code of key, if such an ASCII code
           exists (it contains 65 for "a" and 0 for "é" for instance)
         - [which] contains the same as [key_code]
         I did not find any equivalent to scan codes.
         [location] is useful to distinguish e.g. left shift and right shift. *)
      let key =
        Js.Optdef.case (event##key)
          (fun () -> "")
          Js.to_string
      in
      let location = event##location in
      (* log ("KEY = " ^ key ^ ", " ^ string_of_int location); *)
      Key.of_js key location
    in

    let on_key_down (event: Dom_html.keyboardEvent Js.t) =
      (* Js_of_ocaml does not implement the repeat property, it seems. *)
      let key = key_of_event event in
      Key.pressed := Scan_code_set.add key.scan_code !Key.pressed;
      on_key_down key;
      capture_event event true
    in

    let on_key_up (event: Dom_html.keyboardEvent Js.t) =
      let key = key_of_event event in
      Key.pressed := Scan_code_set.remove key.scan_code !Key.pressed;
      on_key_up key;
      capture_event event true
    in

    let draw_rect (context: Dom_html.canvasRenderingContext2D Js.t)
        ~x ~y ~w ~h ~color ~fill =
      let color = make_color color in
      if fill then
        (
          context##fillStyle <- color;
          context##fillRect(float x, float y, float w, float h)
        )
      else
        (
          context##strokeStyle <- color;
          context##rect(float x, float y, float w, float h) (* TODO: strokeRect instead??? *)
        )
    in

    let rec on_animation_frame (canvas: Dom_html.canvasElement Js.t)
        (now: float) =
      let context = canvas##getContext(Dom_html._2d_) in
      widget := Widget.place window.w window.h (make_ui ());
      (
        match clear with
          | None ->
              ()
          | Some color ->
              draw_rect context ~x: 0 ~y: 0 ~w: canvas##width ~h: canvas##height
                ~color ~fill: true
      );
      Widget.draw (draw_rect context) ~x: 0 ~y: 0 !widget;
      (* TODO: sleep? *)
      let elapsed = (now -. !last_frame_time) *. 1000. |> int_of_float in
      last_frame_time := now;
      update elapsed;
      if !continue then
        request_animation_frame canvas
      else (
        canvas##onmousemove <- Dom.handler (fun _ -> Js._true);
        canvas##onmousedown <- Dom.handler (fun _ -> Js._true);
        canvas##onmouseup <- Dom.handler (fun _ -> Js._true);
        Dom_html.window##onkeydown <- Dom.handler (fun _ -> Js._true);
        Dom_html.window##onkeyup <- Dom.handler (fun _ -> Js._true);
        draw_rect context ~x: 0 ~y: 0 ~w: canvas##width ~h: canvas##height
          ~color: (255, 255, 255, 255) ~fill: true;
        if auto_close_window then Window.close window;
      )

    and request_animation_frame canvas =
      let callback = Js.wrap_callback (on_animation_frame canvas) in
      let _: Dom_html.animation_frame_request_id =
        Dom_html.window##requestAnimationFrame(callback)
      in
      ()
    in

    let on_load _ =
      (* Create <canvas>. *)
      let canvas = Dom_html.(createCanvas document) in
      canvas##width <- window.w;
      canvas##height <- window.h;
      canvas##onmousemove <- Dom.handler on_mouse_move;
      canvas##onmousedown <- Dom.handler on_mouse_down;
      canvas##onmouseup <- Dom.handler on_mouse_up;
      Dom_html.window##onkeydown <- Dom.handler on_key_down;
      Dom_html.window##onkeyup <- Dom.handler on_key_up;

      (* Append <canvas> to <body>. *)
      let body =
        let elements =
          Dom_html.window##document##getElementsByTagName(Js.string "body")
        in
        Js.Opt.get elements##item(0) (fun () -> failwith "no <body>")
      in
      (* TODO: let the user decide where he wants to put the canvas *)
      let _: Dom.node Js.t = body##appendChild((canvas :> Dom.node Js.t)) in

      (* Start the main loop. *)
      Key.pressed := Scan_code_set.empty;
      window.context <- Some (canvas##getContext(Dom_html._2d_));
      request_animation_frame canvas;

      Js._true
    in

    Dom_html.window##onload <- Dom.handler on_load

end
