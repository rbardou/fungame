module Make (Fungame: Fungame_sig.S) =
struct

  open Fungame
  open Widget

  let window = Window.create ()
  let img = Image.load window
  let font = Font.load window

  (* We assume this example is launched from the main directory of Fungame. *)
  let sansation = font "examples/sansation/Sansation_Regular.ttf" 24
  let bat = img "examples/bat.png"
  let quit_text = Font.render sansation "Quit"
  let wrapped_text =
    Font.render ~mode: (Wrapped 100) ~color: (255, 0, 0, 255) sansation
      "Text can be wrapped."
  let kick_drum_1 = Sound.load "examples/samples/Kick-Drum-1.wav"

  let player_x = ref 40
  let player_y = ref 20

  let quit_button = Button.create ()

  let button_color button =
    if Button.is_under_cursor button then
      if Button.is_down button then
        100, 50, 0, 255
      else
        250, 150, 0, 255
    else
      200, 100, 0, 255

  let play_sound () =
    Sound.play ~loops: 2 kick_drum_1

  let key_down key =
    print_endline ("DOWN " ^ Key.show key ^ " / " ^ Key.show_scan_code key);
    match Key.scan_code key with
      | Space -> Sound.play kick_drum_1
      | Escape -> Main_loop.quit ()
      | _ -> ()

  let key_repeat key =
    print_endline ("REPEAT " ^ Key.show key ^ " / " ^ Key.show_scan_code key)

  let key_up key =
    print_endline ("UP " ^ Key.show key ^ " / " ^ Key.show_scan_code key)

  let update elapsed =
    (* print_endline ("elapsed = " ^ string_of_int elapsed); *)
    if Key.is_down (Key.of_scan_code Left) then player_x := !player_x - 1;
    if Key.is_down (Key.of_scan_code Right) then player_x := !player_x + 1;
    if Key.is_down (Key.of_scan_code Up) then player_y := !player_y - 1;
    if Key.is_down (Key.of_scan_code Down) then player_y := !player_y + 1;
    ()

  let () =
    Main_loop.run
      ~on_key_down: key_down
      ~on_key_repeat: key_repeat
      ~on_key_up: key_up
      ~fps: 60
      ~update
      window
    @@ fun () ->
    [
      rect ~fill: true ~color: (50, 50, 50, 255) ();
      hsplitl [
        box [
          rect ~fill: true ~color: (255, 50, 50, 255) ();
          rect ~fill: true ~color: (100, 100, 0, 255) ~w: 20 ~h: 10 ()
          |> center |> middle;
          image bat |> center |> middle;
          image bat |> at !player_x !player_y;
        ];
        margin_box ~left: 20 ~top: 15 ~right: 10 ~bottom: 5 [
          rect ~fill: true ~color: (50, 255, 50, 255) ();
          hbox [
            button quit_button Main_loop.quit [
              rect
                ~fill: true
                ~color: (button_color quit_button)
                ~w: (Image.width quit_text + 10)
                ~h: (Image.height quit_text + 10)
                ();
              margin ~all: 5 (image quit_text);
            ];
            rect ~fill: true ~color: (100, 100, 0, 255) ~w: 20 ~h: 10 ()
            |> right_clickable play_sound;
            rect ~fill: true ~color: (200, 200, 0, 255) ~w: 40 ~h: 20 ();
          ]
          |> right;
          vbox [
            rect ~fill: true ~color: (200, 100, 0, 255) ~w: 10 ~h: 10 ();
            rect ~fill: true ~color: (100, 100, 0, 255) ~w: 20 ~h: 10 ();
            rect ~fill: true ~color: (200, 200, 0, 255) ~w: 40 ~h: 20 ();
          ]
          |> bottom |> right;
        ];
        vsplitl [
          rect ~fill: true ~color: (50, 50, 255, 255) ();
          margin_box ~all: 5 [
            rect ~fill: true ~color: (255, 255, 255, 255) ();
            rect ~fill: true ~color: (200, 100, 0, 255) ~w: 10 ~h: 10 ()
            |> ratio ~h: 0.5 ~v: 0.2;
          ];
          rect ~fill: true ~color: (0, 0, 0, 255) ();
        ]
      ];
      image wrapped_text |> bottom |> right;
      text sansation ~color: (255, 255, 255, 255)
        "Text can also be rendered on the fly, memoized."
      |> bottom;
    ]

end
