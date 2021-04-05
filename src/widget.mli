(** Widgets and event handling. *)

(** Widgets. *)
type t

(** {2 Layout} *)

(** Widgets that have been laid out with {!lay_out}.

    This type forces layout functions to lay out children. *)
type laid_out

(** Get the width of a widget that has been laid out. *)
val w: laid_out -> int

(** Get the height of a widget that has been laid out. *)
val h: laid_out -> int

(** Widget children are laid out widgets with a position relative to their parent. *)
type child =
  {
    x: int;
    y: int;
    child: laid_out;
  }

(** Once laid out, widgets have dimensions and children. *)
and layout =
  {
    w: int;
    h: int;
    children: child list;
  }

(** Available space to lay out a widget tree. *)
type available_space =
  {
    available_w: int option;
    available_h: int option;
  }

(** Lay out a widget tree.

    Use this in your layout functions (the ones you pass to [create] to lay out children.
    The root widget should be laid out using [lay_out_window] instead. *)
val lay_out: t -> available_space -> laid_out

(** {2 Windows} *)

(** Windows are root widgets plus some general information about mouse and keyboard state. *)
type window

(** Create a new window. *)
val create_window: unit -> window

(** Lay out a widget tree inside a window.

    This replaces the current widget tree of the window. *)
val lay_out_window: window -> t -> available_space -> unit

(** {2 Creation} *)

(** Create a widget.

    The argument is a function that is used to compute the layout of the widget.
    It depends on available space, which can be used to make the widget bigger or
    smaller depending on how much space it has at its disposal. *)
val create: (available_space -> layout) -> t

(** {2 Draw} *)

(** Set the function used to draw a widget.

    The function is given boundaries: the position [(x, y)],
    the width [w] and the height [h] of a rectangle.
    The function should only draw in the rectangle boundaries. *)
val set_draw: t -> (x: int -> y: int -> w: int -> h: int -> unit) -> unit

(** Draw a window.

    You should call [lay_out_window] first to ensure there is something to draw. *)
val draw: ?x: int -> ?y: int -> ?w: int -> ?h: int -> window -> unit

(** {2 Events} *)

(** Event handlers can either [Capture] or [Ignore] events.

    Events propagate from innermost children to the root widget.
    Once events are [Capture]d, they are not propagated to parents anymore. *)
type handler_result =
  | Capture
  | Ignore

(** {3 Keyboard Events} *)

(** Information about a key down event.

    [shift], [ctrl] and [alt] are [true] if the Shift, Control or Alt keys
    (respectively) were also pressed at the time the event occurred.

    [repeat] is [true] if the key was automatically repeated after a delay
    because the user did not release the key. *)
type key_down_event =
  {
    key: Key.t;
    shift: bool;
    ctrl: bool;
    alt: bool;
    repeat: bool;
  }

(** Add a key down event handler. *)
val on_key_down: t -> (key_down_event -> handler_result) -> unit

(** Trigger a key down event.

    [repeat] shall be [true] if the key was automatically repeated after a delay
    because the user did not release the key. *)
val key_down: window -> key: Key.t -> repeat:bool -> unit

(** Information about a key up event.

    This is very similar to [key_down_event], except that there is no [repeat]. *)
type key_up_event =
  {
    key: Key.t;
    shift: bool;
    ctrl: bool;
    alt: bool;
  }

(** Add a key up event handler. *)
val on_key_up: t -> (key_up_event -> handler_result) -> unit

(** Trigger a key up event. *)
val key_up: window -> key: Key.t -> unit

(** {3 Mouse Events} *)

(** Information about a mouse button event.

    This is used both for mouse down and mouse up events.
    The position of the cursor, relatively to the widget, is given by [x] and [y]. *)
type mouse_button_event =
  {
    button: Mouse_button.t;
    x: int;
    y: int;
  }

(** Add a mouse down event handler. *)
val on_mouse_down: t -> (mouse_button_event -> handler_result) -> unit

(** Trigger a mouse down event. *)
val mouse_down: window -> button: Mouse_button.t -> x: int -> y: int -> unit

(** Add a mouse up event handler. *)
val on_mouse_up: t -> (mouse_button_event -> handler_result) -> unit

(** Trigger a mouse up event. *)
val mouse_up: window -> button: Mouse_button.t -> x: int -> y: int -> unit

(** Information about a mouse move event.

    The position of the cursor, relatively to the widget, is given by [x] and [y].
    It can be outside the widget if the widget captured the mouse (by keeping
    the left mouse button pressed). *)
type mouse_move_event =
  {
    x: int;
    y: int;
  }

(** Add a mouse move event handler. *)
val on_mouse_move: t -> (mouse_move_event -> handler_result) -> unit

(** Trigger a mouse move event. *)
val mouse_move: window -> x: int -> y: int -> unit

(** Add a mouse wheel event handler. *)
val on_mouse_wheel: t -> (mouse_move_event -> handler_result) -> unit

(** Trigger a mouse wheel event. *)
val mouse_wheel: window -> x: int -> y: int -> unit

(** {2 Keyboard Focus} *)

(** Return whether a widget has keyboard focus. *)
val has_focus: t -> bool

(** Return whether a widget or one of its transitive children has keyboard focus. *)
val has_focus_transitively: t -> bool

(** Give keyboard focus to a widget.

    If the widget itself does not accept focus, focus its parent recursively.
    If no ancestor accepts focus, keep current focus. *)
val focus: t -> unit

(** Give keyboard focus to the first innermost child with a keyboard event handler. *)
val focus_first: ?sort: (child list -> child list) -> window -> unit

(** Give keyboard focus to the last innermost child with a keyboard event handler. *)
val focus_last: ?sort: (child list -> child list) -> window -> unit

(** Cycle keyboard focus forward in the list of widgets with a keyboard event handler. *)
val focus_next: ?sort: (child list -> child list) -> window -> unit

(** Cycle keyboard focus backward in the list of widgets with a keyboard event handler. *)
val focus_previous: ?sort: (child list -> child list) -> window -> unit

(** {2 Mouse State} *)

(** Return whether there is a widget capturing mouse events. *)
val mouse_is_captured: window -> bool

(** Return whether a widget is capturing mouse events.

    When the user presses the left mouse button, the widget under the cursor
    starts capturing mouse events. Capture is released once the user releases the
    left mouse button. While a widget captures mouse events, all mouse events
    for all buttons are sent to this widget or (if the event propagates) to its
    ancestors, even if the widget is no longer under the cursor. *)
val is_captured: t -> bool

(** Return whether a widget or one of its transitive children is capturing mouse events. *)
val is_captured_transitively: t -> bool

(** Return whether a widget is the widget immediately under the mouse cursor. *)
val is_under_cursor: t -> bool

(** Return whether a widget or one of its children is under the mouse cursor. *)
val is_under_cursor_transitively: t -> bool

(** Return whether a widget is virtually under the mouse cursor.

    A widget [w] is virtually under the mouse cursor if [w] is under the cursor
    and either no widget is captured, or the captured widget is [w] or one of its
    children. *)
val is_virtually_under_cursor: t -> bool

(** Return whether a widget or one of its children is virtually under the mouse cursor. *)
val is_virtually_under_cursor_transitively: t -> bool

(* TODO: store a cursor name in widgets to be able to draw a different cursor
   depending on which widget the cursor is above? *)

(** {2 High-Level Events} *)

(** High-level events are implemented using events that were introduced
    above in this module, so they may capture them. *)

(** Set up a handler to trigger when a widget is clicked.

    This event triggers when [on_mouse_down] is followed by [on_mouse_up],
    if both events are about the left mouse button and if the cursor is still
    on the widget when the button is released. The cursor may have left the
    widget temporarily between the press and the release of the button.

    This event also triggers when the user presses one of the [Return] key. *)
val on_click: t -> (unit -> unit) -> unit
