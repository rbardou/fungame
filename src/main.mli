(** Main loop which handles input events and video output. *)

(** Run the game.

    Call [draw] to draw, then handle events.
    Then call [draw] again and start over, looping until the user exits.

    If [clear] is specified, clear screen using given color before drawing.

    If [auto_close_window] is [true], call [Window.close] at the end of the
    main loop. Default is [true].

    If [auto_close_sound] is [true], call [Sound.close] at the end of the
    main loop. Default is [true].

    If [fps] is specified, add a delay after each iteration to try to
    maintain a framerate of [fps] frames per second. Drop frames if
    necessary, but not too many consecutively.

    Note that specifying [fps] if [vsync] is on will not look very smooth
    if the monitor refresh rate and [fps] are not multiples of one another.

    If [update] is specified, call it after each iteration with the number
    of seconds elapsed since the last time it was called.

    The [~repeat] argument given to [on_key_down] is [false] for the initial key press.
    The event is repeated regularly, with a delay which depends on the system
    (with a greater delay for the first repetition, usually), until the user
    releases the key. For those repetitions, [~repeat] is [true].

    Note about controllers: if the player unplugs a controller and plugs it back,
    it gets a new, different [id]. So it looks like a new controller. *)
val run:
  window: Window.t ->
  ?clear: Color.t ->
  ?auto_close_window: bool ->
  ?auto_close_sound: bool ->
  ?on_key_down: (key: Key.t -> repeat: bool -> unit) ->
  ?on_key_up: (key: Key.t -> unit) ->
  ?on_mouse_down: (button: Mouse_button.t -> x: int -> y: int -> unit) ->
  ?on_mouse_move: (x: int -> y: int -> unit) ->
  ?on_mouse_up: (button: Mouse_button.t -> x: int -> y: int -> unit) ->
  ?on_mouse_wheel: (x: int -> y: int -> unit) ->
  ?on_gamepad_added: (id: int -> unit) ->
  ?on_gamepad_removed: (id: int -> unit) ->
  ?on_gamepad_move: (id: int -> axis: Gamepad.axis -> value: int -> unit) ->
  ?on_gamepad_down: (id: int -> button: Gamepad.button -> unit) ->
  ?on_gamepad_up: (id: int -> button: Gamepad.button -> unit) ->
  ?fps: int ->
  ?update: (float -> unit) ->
  ?draw: (unit -> unit) ->
  unit -> unit

(** Same as [run], but use widgets.

    This creates a widget window and passes mouse and keyboard events to it,
    and uses [Widget.draw] to draw.
    The [update] function is given the [Widget.lay_out_window] function applied
    to the widget window with the window size as available space.
    Use it when you want to change the root widget or its children. *)
val run_widget:
  window: Window.t ->
  ?clear: Color.t ->
  ?auto_close_window: bool ->
  ?auto_close_sound: bool ->
  ?on_gamepad_added: (id: int -> unit) ->
  ?on_gamepad_removed: (id: int -> unit) ->
  ?on_gamepad_move: (id: int -> axis: Gamepad.axis -> value: int -> unit) ->
  ?on_gamepad_down: (id: int -> button: Gamepad.button -> unit) ->
  ?on_gamepad_up: (id: int -> button: Gamepad.button -> unit) ->
  ?fps: int ->
  ?update: ((Widget.t -> unit) -> float -> unit) ->
  unit -> unit

(** Exit the main loop.

    Call this from event handlers or from [update]. *)
val quit: unit -> unit
