open Fungame_sdl
open Widget

let quit_button = Button.create quit

let button_color button =
  if Button.is_under_cursor button then
    if Button.is_down button then
      100, 50, 0, 255
    else
      250, 150, 0, 255
  else
    200, 100, 0, 255

let () =
  run @@ fun () ->
  [
    rect ~fill: true ~color: (50, 50, 50, 255) ();
    hsplitl [
      rect ~fill: true ~color: (255, 50, 50, 255) ();
      margin_box ~left: 20 ~top: 15 ~right: 10 ~bottom: 5 [
        rect ~fill: true ~color: (50, 255, 50, 255) ();
        hbox [
          button quit_button [
            rect
              ~fill: true
              ~color: (button_color quit_button)
              ~w: 10 ~h: 10
              ();
          ];
          rect ~fill: true ~color: (100, 100, 0, 255) ~w: 20 ~h: 10 ()
          |> right_clickable quit;
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
  ]
