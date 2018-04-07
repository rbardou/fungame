open Fungame_sdl
open Widget

let () =
  run @@ fun () ->
  [
    rect ~fill: true ~color: (50, 50, 50, 255) ();
    hsplitl [
      rect ~fill: true ~color: (255, 50, 50, 255) ();
      margin_box ~left: 20 ~top: 15 ~right: 10 ~bottom: 5 [
        rect ~fill: true ~color: (50, 255, 50, 255) ();
        hbox [
          rect ~fill: true ~color: (200, 100, 0, 255) ~w: 10 ~h: 10 ();
          rect ~fill: true ~color: (100, 100, 0, 255) ~w: 20 ~h: 10 ();
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
