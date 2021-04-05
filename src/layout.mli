(** Common widget layout functions. *)

(** Layout functions. *)
type t = Widget.available_space -> Widget.layout

(** A layout which takes no space and with no children.

    [w] and [h] can be used to make the widget actually take space. *)
val empty: ?w: int -> ?h: int -> unit -> t

(** A layout with one child.

    By default, the widget is placed at position [(0, 0)] but you
    can override this with [x] and [y]. This will cause the layout to grow in size
    to contain this offset.

    Use [w] and/or [h] to override the available space for the widget. *)
val put: ?x: int -> ?y: int -> ?w: int -> ?h: int -> Widget.t -> t

(** Merge several layouts together.

    Apply all layouts with available space.
    Return a layout which is large enough to contain all the resulting layouts,
    and which contains all their children. *)
val box: t list -> t

(** Same as {!box} but arrange layouts horizontally.

    Each layout is placed next to its previous layout in the list.

    Each layout is given the same available height (which is the one received by
    the box), but available width is reduced each time a layout is added.
    Note that this means that if a layout fills available width, there is no
    available width anymore for the remaining layouts.

    [sep] is a space to add between each layout. It defaults to [0].

    If [center] is [true], widgets are centered vertically in the resulting box.
    Default is [false]. *)
val hbox: ?sep: int -> ?center: bool -> t list -> t

(** Same as {!vbox} but vertically (and [center] centers horizontally). *)
val vbox: ?sep: int -> ?center: bool -> t list -> t

(** Add margins to a layout.

    Apply the layout with available space minus the margins,
    then enlarge the resulting layout and move children to add the margins.

    The left margin is [left + horizontal + all].
    The right margin is [right + horizontal + all].
    The top margin is [top + vertical + all].
    The bottom margin is [bottom + vertical + all]. *)
val margin:
  ?left: int ->
  ?right: int ->
  ?top: int ->
  ?bottom: int ->
  ?horizontal: int ->
  ?vertical: int ->
  ?all: int ->
  t -> t

(** Set the size of a layout.

    Apply the layout with the size as available space,
    and set the resulting layout size to the fixed size.

    If [w] is not specified, ignore width (keep available width and do not resize it).
    If [h] is not specified, ignore height. *)
val size: ?w: int -> ?h: int -> t -> t

(** Expand a layout to use available size.

    Apply the layout with available space,
    and set the resulting layout size to available space.

    If available space is infinite, do not change the resulting layout size. *)
val fill: t -> t

(** Expand a layout to use available horizontal space. *)
val hfill: t -> t

(** Expand a layout to use available vertical space. *)
val vfill: t -> t

(** Expand a layout if it is too small.

    Apply the layout with available space, enlarged if too small.
    If the resulting size is too small, enlarge it.

    If [w] is not specified, ignore width.
    If [h] is not specified, ignore height. *)
val min: ?w: int -> ?h: int -> t -> t

(** Shrink a layout if it is too large.

    If available space is too large, reduce it.
    Apply the layout with (potentially reduced) available space.
    If the resulting layout is too large (i.e. it uses more that what was given
    to it as available space), reduce it.

    If [w] is not specified, ignore width.
    If [h] is not specified, ignore height. *)
val max: ?w: int -> ?h: int -> t -> t

(** Center a layout in available space.

    Apply the layout with available space.
    Then move children to center them in available space.
    The result thus fills available space like {!fill} does.

    If space is infinite in one direction, do nothing for this direction.

    Relative positions of children is unchanged.
    Children are grouped as if they were a single widget at position [(0, 0)] and
    with size [(w, h)] such that [w] is the maximum of [child_x + child_w],
    for each child, where [child_x] is the position of the child and [child_w] is its size.
    Then, all children are moved by the same offset such that this whole group is centered.

    Because position [(0, 0)] is always considered part of the children,
    for best results you should have at least one child at this position and no child
    with negative positions, unless you want to center children and then move them
    again by an offset. *)
val center: t -> t

(** Same as {!center}, but only horizontally. *)
val hcenter: t -> t

(** Same as {!center}, but only vertically. *)
val vcenter: t -> t

(** Push children to the bottom-right.

    Similarly to {!center}, group children and put the group on the bottom-right
    of the layout. *)
val push: t -> t

(** Same as {!push}, but only horizontally (i.e. to the right). *)
val hpush: t -> t

(** Same as {!push}, but only vertically (i.e. to the bottom). *)
val vpush: t -> t

