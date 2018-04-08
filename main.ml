open Fungame_sdl
open Widget

let window = Window.create ()
let img = Image.load window
let font = Font.load window

let sansation = font "sansation/Sansation_Regular.ttf" 24
let bat = img "bat.png"
let quit_text = Font.render sansation "Quit"
let wrapped_text =
  Font.render ~mode: (Wrapped 100) ~color: (255, 0, 0, 255) sansation
    "Text can be wrapped."
let kick_drum_1 = Sound.load "samples/Kick-Drum-1.wav"

let quit_button = Button.create Main_loop.quit

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

let key_event kind key =
  print_endline (kind ^ " " ^ Key.show key ^ " / " ^ Key.show_scan_code key);
  match Key.scan_code key with
    | Space -> if kind <> "UP" then Sound.play kick_drum_1
    | Escape -> Main_loop.quit ()
    | _ -> ()

let () =
  Main_loop.run
    ~on_key_down: (key_event "DOWN")
    ~on_key_repeat: (key_event "REPEAT")
    ~on_key_up: (key_event "UP")
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
        image bat |> at 40 20;
      ];
      margin_box ~left: 20 ~top: 15 ~right: 10 ~bottom: 5 [
        rect ~fill: true ~color: (50, 255, 50, 255) ();
        hbox [
          button quit_button [
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
  ]
