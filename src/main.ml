open Tsdl

exception Quit

let quit () =
  raise Quit

let decode_mouse_button = function
  | 1 -> Mouse_button.Left
  | 2 -> Mouse_button.Middle
  | 3 -> Mouse_button.Right
  | i -> Mouse_button.Other i

let decode_gamepad_axis = function
  | 0 -> Gamepad.Left_x
  | 1 -> Gamepad.Left_y
  | 2 -> Gamepad.Right_x
  | 3 -> Gamepad.Right_y
  | 4 -> Gamepad.Left_trigger
  | 5 -> Gamepad.Right_trigger
  | n -> Gamepad.Other n

let decode_gamepad_button = function
  | 0 -> Gamepad.A
  | 1 -> Gamepad.B
  | 2 -> Gamepad.X
  | 3 -> Gamepad.Y
  | 4 -> Gamepad.Back
  | 5 -> Gamepad.Guide
  | 6 -> Gamepad.Start
  | 7 -> Gamepad.Left_stick
  | 8 -> Gamepad.Right_stick
  | 9 -> Gamepad.Left_shoulder
  | 10 -> Gamepad.Right_shoulder
  | 11 -> Gamepad.Dpad_up
  | 12 -> Gamepad.Dpad_down
  | 13 -> Gamepad.Dpad_left
  | 14 -> Gamepad.Dpad_right
  | n -> Gamepad.Other n

type controller =
  {
    instance_id: int;
    controller: Sdl.game_controller;
  }

let run
    ~window
    ?clear
    ?(auto_close_window = true)
    ?(auto_close_sound = true)
    ?(on_key_down = fun ~key: _ ~repeat: _ -> ())
    ?(on_key_up = fun ~key: _ -> ())
    ?(on_mouse_down = fun ~button: _ ~x: _ ~y: _ -> ())
    ?(on_mouse_move = fun ~x: _ ~y: _ -> ())
    ?(on_mouse_up = fun ~button: _ ~x: _ ~y: _ -> ())
    ?(on_mouse_wheel = fun ~x: _ ~y: _ -> ())
    ?(on_gamepad_added = fun ~id: _ -> ())
    ?(on_gamepad_removed = fun ~id: _ -> ())
    ?(on_gamepad_move = fun ~id: _ ~axis: _ ~value: _ -> ())
    ?(on_gamepad_down = fun ~id: _ ~button: _ -> ())
    ?(on_gamepad_up = fun ~id: _ ~button: _ -> ())
    ?fps
    ?(update = fun _ -> ())
    ?(draw = fun () -> ())
    () =
  try
    let controllers: controller list ref = ref [] in

    let renderer = Window.renderer window in

    let clear_if_requested () =
      match clear with
        | None ->
            ()
        | Some color ->
            Window.clear window color
    in

    let draw_frame () =
      clear_if_requested ();
      draw ();
      Sdl.render_present renderer;
      Font.next_frame ();
    in

    let get_ticks () = Sdl.get_ticks () |> Int32.to_int |> float in
    let last_update = ref (get_ticks ()) in
    let last_tick = ref (get_ticks ()) in
    let consecutive_drops = ref 0 in

    (* TODO: Something is weird with this function.
       The need for a "start dropping" section (where we accept negative values)
       means that time measurement is not very reliable? *)
    (* Wait for a little bit to ensure that the frame appears to last for
       about [expected_delay] milliseconds.
       Return whether the next frame should be drawn. *)
    let frame_delay expected_delay =
      let now = get_ticks () in
      let actual_waiting_delay = !last_tick +. expected_delay -. now in
      if actual_waiting_delay > 1. then
        (* We can wait. *)
        (
          Sdl.delay (Int32.of_int (int_of_float actual_waiting_delay));
          last_tick := !last_tick +. expected_delay;
          consecutive_drops := 0;
          true (* We may draw the next frame. *)
        )
      else if actual_waiting_delay >= -. expected_delay then
        (* We are more than one frame late. Start dropping. *)
        (
          last_tick := !last_tick +. expected_delay;
          consecutive_drops := 0;
          true (* We may draw the next frame. *)
        )
      else (
        (* We can't wait and we have to drop a frame. *)
        if !consecutive_drops >= 19 then
          (* We dropped too many frames. Let's forget about it and reset. *)
          (
            consecutive_drops := 0;
            last_tick := now;
            true (* We may draw the next frame. *)
          )
        else
          (
            incr consecutive_drops;
            last_tick := !last_tick +. expected_delay;
            false (* Drop the next frame. *)
          )
      )
    in

    let dropped_frames = ref 0 in

    (* TODO: remove, or make an option *)
    if false then (
      at_exit @@ fun () ->
      Printf.printf "dropped %d frames\n%!" !dropped_frames;
    );

    (* Handle events and then call [update]. *)
    let update_with_events () =
      let event = Sdl.Event.create () in

      while Sdl.poll_event (Some event) do
        let typ = Sdl.Event.get event Sdl.Event.typ in

        if typ = Sdl.Event.quit then
          quit ()

        else if typ = Sdl.Event.key_down then
          let scancode = Sdl.Event.get event Sdl.Event.keyboard_scancode in
          let keycode = Sdl.Event.get event Sdl.Event.keyboard_keycode in
          let repeat = Sdl.Event.get event Sdl.Event.keyboard_repeat in
          let key = Key.of_sdl scancode keycode in
          Key.down key;
          on_key_down ~key ~repeat: (repeat > 0)

        else if typ = Sdl.Event.key_up then
          let scancode = Sdl.Event.get event Sdl.Event.keyboard_scancode in
          let keycode = Sdl.Event.get event Sdl.Event.keyboard_keycode in
          let key = Key.of_sdl scancode keycode in
          Key.up key;
          on_key_up ~key

        else if typ = Sdl.Event.mouse_button_down then
          let x = Sdl.Event.get event Sdl.Event.mouse_button_x in
          let y = Sdl.Event.get event Sdl.Event.mouse_button_y in
          let button = Sdl.Event.get event Sdl.Event.mouse_button_button in
          on_mouse_down ~button: (decode_mouse_button button) ~x ~y

        else if typ = Sdl.Event.mouse_button_up then
          let x = Sdl.Event.get event Sdl.Event.mouse_button_x in
          let y = Sdl.Event.get event Sdl.Event.mouse_button_y in
          let button = Sdl.Event.get event Sdl.Event.mouse_button_button in
          on_mouse_up ~button: (decode_mouse_button button) ~x ~y

        else if typ = Sdl.Event.mouse_motion then
          let x = Sdl.Event.get event Sdl.Event.mouse_motion_x in
          let y = Sdl.Event.get event Sdl.Event.mouse_motion_y in
          on_mouse_move ~x ~y

        else if typ = Sdl.Event.mouse_wheel then
          let x = Sdl.Event.get event Sdl.Event.mouse_wheel_x in
          let y = Sdl.Event.get event Sdl.Event.mouse_wheel_y in
          let direction = Sdl.Event.get event Sdl.Event.mouse_wheel_direction in
          let x, y = if direction = Sdl.Event.mouse_wheel_flipped then -x, -y else x, y in
          on_mouse_wheel ~x ~y

        else if typ = Sdl.Event.controller_device_added then
          (* For this event, [which] is the index in the internal SDL array.
             Those indexes are re-used when controllers are removed and new ones are added.
             Once a controller is opened though, it gets an instance id, which is the
             [which] field that we receive for all other events. This instance id is unique
             for each call to [game_controller_open]. Note that we need to open to receive
             events other than [game_controller_added]. *)
          let which = Sdl.Event.get event Sdl.Event.controller_device_which |> Int32.to_int in
          match Sdl.game_controller_open which with
            | Error (`Msg _) ->
                (* TODO: display error as a warning? *)
                ()
            | Ok controller ->
                match Sdl.game_controller_get_joystick controller with
                  | Error (`Msg _) ->
                      (* TODO: display error as a warning? *)
                      ()
                  | Ok joystick ->
                      match Sdl.joystick_instance_id joystick with
                        | Error (`Msg _) ->
                            (* TODO: display error as a warning? *)
                            ()
                        | Ok instance_id ->
                            let instance_id = Int32.to_int instance_id in
                            controllers := { instance_id; controller } :: !controllers;
                            on_gamepad_added ~id: instance_id

        else if typ = Sdl.Event.controller_device_removed then
          let which = Sdl.Event.get event Sdl.Event.controller_device_which |> Int32.to_int in
          let rec loop triggered acc = function
            | [] ->
                controllers := acc
            | head :: tail ->
                if head.instance_id = which then
                  (
                    Sdl.game_controller_close head.controller;
                    if not triggered then on_gamepad_removed ~id: which;
                    loop true acc tail
                  )
                else
                  loop triggered (head :: acc) tail
          in
          loop false [] !controllers

        else if typ = Sdl.Event.controller_axis_motion then
          let id = Sdl.Event.get event Sdl.Event.controller_axis_which |> Int32.to_int in
          let axis =
            Sdl.Event.get event Sdl.Event.controller_axis_axis
            |> decode_gamepad_axis
          in
          let value = Sdl.Event.get event Sdl.Event.controller_axis_value in
          on_gamepad_move ~id ~axis ~value

        else if typ = Sdl.Event.controller_button_down then
          let id = Sdl.Event.get event Sdl.Event.controller_button_which |> Int32.to_int in
          let button =
            Sdl.Event.get event Sdl.Event.controller_button_button
            |> decode_gamepad_button
          in
          on_gamepad_down ~id ~button

        else if typ = Sdl.Event.controller_button_up then
          let id = Sdl.Event.get event Sdl.Event.controller_button_which |> Int32.to_int in
          let button =
            Sdl.Event.get event Sdl.Event.controller_button_button
            |> decode_gamepad_button
          in
          on_gamepad_up ~id ~button

      done;

      let now = get_ticks () in
      let elapsed = now -. !last_update in
      last_update := now;
      update (elapsed /. 1000.)
    in

    let rec highest_possible_fps_loop () =
      draw_frame ();
      update_with_events ();
      highest_possible_fps_loop ()
    in

    let rec target_fps_loop expected_delay =
      if frame_delay expected_delay then draw_frame () else incr dropped_frames;
      update_with_events ();
      target_fps_loop expected_delay
    in

    try
      match fps with
        | None ->
            highest_possible_fps_loop ()
        | Some fps ->
            target_fps_loop (1000. /. float fps)
    with Quit ->
      Font.clear_memo ();
      if auto_close_window then Window.close window;
      if auto_close_sound then Sound.close ();
      Sdl.quit ()
  with exn ->
    prerr_endline (Printexc.to_string exn);
    Sdl.quit ();
    exit 1

let run_widget ~window ?clear ?auto_close_window ?auto_close_sound
    ?on_gamepad_added ?on_gamepad_removed ?on_gamepad_move ?on_gamepad_down ?on_gamepad_up
    ?fps ?(update = fun _ _ -> ()) () =
  let widget_window = Widget.create_window () in
  let available_space: Widget.available_space =
    {
      available_w = Some (Window.w window);
      available_h = Some (Window.h window);
    }
  in
  let update elapsed =
    update (fun widget -> Widget.lay_out_window widget_window widget available_space) elapsed
  in
  run
    ~window
    ?clear
    ?auto_close_window
    ?auto_close_sound
    ~on_key_down: (Widget.key_down widget_window)
    ~on_key_up: (Widget.key_up widget_window)
    ~on_mouse_down: (Widget.mouse_down widget_window)
    ~on_mouse_move: (Widget.mouse_move widget_window)
    ~on_mouse_up: (Widget.mouse_up widget_window)
    ~on_mouse_wheel: (Widget.mouse_wheel widget_window)
    ?on_gamepad_added
    ?on_gamepad_removed
    ?on_gamepad_move
    ?on_gamepad_down
    ?on_gamepad_up
    ?fps
    ~update
    ~draw: (fun () -> Widget.draw widget_window)
    ()
