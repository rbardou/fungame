(** Key codes, independant of current keyboard layout. *)

(** Scan codes. *)
type t =
  | A
  | Ac_back
  | Ac_bookmarks
  | Ac_forward
  | Ac_home
  | Ac_refresh
  | Ac_search
  | Ac_stop
  | Again
  | Alterase
  | Apostrophe
  | App1
  | App2
  | Application
  | Audiomute
  | Audionext
  | Audioplay
  | Audioprev
  | Audiostop
  | B
  | Backslash
  | Backspace
  | Brightnessdown
  | Brightnessup
  | C
  | Calculator
  | Cancel
  | Capslock
  | Clear
  | Clearagain
  | Comma
  | Computer
  | Copy
  | Crsel
  | Currencysubunit
  | Currencyunit
  | Cut
  | D
  | Decimalseparator
  | Delete
  | Displayswitch
  | Down
  | E
  | Eject
  | End
  | Equals
  | Escape
  | Execute
  | Exsel
  | F
  | F1
  | F10
  | F11
  | F12
  | F13
  | F14
  | F15
  | F16
  | F17
  | F18
  | F19
  | F2
  | F20
  | F21
  | F22
  | F23
  | F24
  | F3
  | F4
  | F5
  | F6
  | F7
  | F8
  | F9
  | Find
  | G
  | Grave
  | H
  | Help
  | Home
  | I
  | Insert
  | International1
  | International2
  | International3
  | International4
  | International5
  | International6
  | International7
  | International8
  | International9
  | J
  | K
  | K0
  | K1
  | K2
  | K3
  | K4
  | K5
  | K6
  | K7
  | K8
  | K9
  | Kbdillumdown
  | Kbdillumtoggle
  | Kbdillumup
  | Kp_0
  | Kp_00
  | Kp_000
  | Kp_1
  | Kp_2
  | Kp_3
  | Kp_4
  | Kp_5
  | Kp_6
  | Kp_7
  | Kp_8
  | Kp_9
  | Kp_a
  | Kp_ampersand
  | Kp_at
  | Kp_b
  | Kp_backspace
  | Kp_binary
  | Kp_c
  | Kp_clear
  | Kp_clearentry
  | Kp_colon
  | Kp_comma
  | Kp_d
  | Kp_dblampersand
  | Kp_dblverticalbar
  | Kp_decimal
  | Kp_divide
  | Kp_e
  | Kp_enter
  | Kp_equals
  | Kp_equalsas400
  | Kp_exclam
  | Kp_f
  | Kp_greater
  | Kp_hash
  | Kp_hexadecimal
  | Kp_leftbrace
  | Kp_leftparen
  | Kp_less
  | Kp_memadd
  | Kp_memclear
  | Kp_memdivide
  | Kp_memmultiply
  | Kp_memrecall
  | Kp_memstore
  | Kp_memsubtract
  | Kp_minus
  | Kp_multiply
  | Kp_octal
  | Kp_percent
  | Kp_period
  | Kp_plus
  | Kp_plusminus
  | Kp_power
  | Kp_rightbrace
  | Kp_rightparen
  | Kp_space
  | Kp_tab
  | Kp_verticalbar
  | Kp_xor
  | L
  | Lalt
  | Lang1
  | Lang2
  | Lang3
  | Lang4
  | Lang5
  | Lang6
  | Lang7
  | Lang8
  | Lang9
  | Lctrl
  | Left
  | Leftbracket
  | Lgui
  | Lshift
  | M
  | Mail
  | Mediaselect
  | Menu
  | Minus
  | Mode
  | Mute
  | N
  | Nonusbackslash
  | Nonushash
  | Numlockclear
  | O
  | Oper
  | Out
  | P
  | Pagedown
  | Pageup
  | Paste
  | Pause
  | Period
  | Power
  | Printscreen
  | Prior
  | Q
  | R
  | Ralt
  | Rctrl
  | Return
  | Return2
  | Rgui
  | Right
  | Rightbracket
  | Rshift
  | S
  | Scrolllock
  | Select
  | Semicolon
  | Separator
  | Slash
  | Sleep
  | Space
  | Stop
  | Sysreq
  | T
  | Tab
  | Thousandsseparator
  | U
  | Undo
  | Unknown
  | Up
  | V
  | Volumedown
  | Volumeup
  | W
  | Www
  | X
  | Y
  | Z

(** Compare two scan codes. *)
let compare = (Pervasives.compare: t -> t -> int)

(** Convert a scan code to a string. *)
let show = function
  | A -> "A"
  | Ac_back -> "Ac_back"
  | Ac_bookmarks -> "Ac_bookmarks"
  | Ac_forward -> "Ac_forward"
  | Ac_home -> "Ac_home"
  | Ac_refresh -> "Ac_refresh"
  | Ac_search -> "Ac_search"
  | Ac_stop -> "Ac_stop"
  | Again -> "Again"
  | Alterase -> "Alterase"
  | Apostrophe -> "Apostrophe"
  | App1 -> "App1"
  | App2 -> "App2"
  | Application -> "Application"
  | Audiomute -> "Audiomute"
  | Audionext -> "Audionext"
  | Audioplay -> "Audioplay"
  | Audioprev -> "Audioprev"
  | Audiostop -> "Audiostop"
  | B -> "B"
  | Backslash -> "Backslash"
  | Backspace -> "Backspace"
  | Brightnessdown -> "Brightnessdown"
  | Brightnessup -> "Brightnessup"
  | C -> "C"
  | Calculator -> "Calculator"
  | Cancel -> "Cancel"
  | Capslock -> "Capslock"
  | Clear -> "Clear"
  | Clearagain -> "Clearagain"
  | Comma -> "Comma"
  | Computer -> "Computer"
  | Copy -> "Copy"
  | Crsel -> "Crsel"
  | Currencysubunit -> "Currencysubunit"
  | Currencyunit -> "Currencyunit"
  | Cut -> "Cut"
  | D -> "D"
  | Decimalseparator -> "Decimalseparator"
  | Delete -> "Delete"
  | Displayswitch -> "Displayswitch"
  | Down -> "Down"
  | E -> "E"
  | Eject -> "Eject"
  | End -> "End"
  | Equals -> "Equals"
  | Escape -> "Escape"
  | Execute -> "Execute"
  | Exsel -> "Exsel"
  | F -> "F"
  | F1 -> "F1"
  | F10 -> "F10"
  | F11 -> "F11"
  | F12 -> "F12"
  | F13 -> "F13"
  | F14 -> "F14"
  | F15 -> "F15"
  | F16 -> "F16"
  | F17 -> "F17"
  | F18 -> "F18"
  | F19 -> "F19"
  | F2 -> "F2"
  | F20 -> "F20"
  | F21 -> "F21"
  | F22 -> "F22"
  | F23 -> "F23"
  | F24 -> "F24"
  | F3 -> "F3"
  | F4 -> "F4"
  | F5 -> "F5"
  | F6 -> "F6"
  | F7 -> "F7"
  | F8 -> "F8"
  | F9 -> "F9"
  | Find -> "Find"
  | G -> "G"
  | Grave -> "Grave"
  | H -> "H"
  | Help -> "Help"
  | Home -> "Home"
  | I -> "I"
  | Insert -> "Insert"
  | International1 -> "International1"
  | International2 -> "International2"
  | International3 -> "International3"
  | International4 -> "International4"
  | International5 -> "International5"
  | International6 -> "International6"
  | International7 -> "International7"
  | International8 -> "International8"
  | International9 -> "International9"
  | J -> "J"
  | K -> "K"
  | K0 -> "K0"
  | K1 -> "K1"
  | K2 -> "K2"
  | K3 -> "K3"
  | K4 -> "K4"
  | K5 -> "K5"
  | K6 -> "K6"
  | K7 -> "K7"
  | K8 -> "K8"
  | K9 -> "K9"
  | Kbdillumdown -> "Kbdillumdown"
  | Kbdillumtoggle -> "Kbdillumtoggle"
  | Kbdillumup -> "Kbdillumup"
  | Kp_0 -> "Kp_0"
  | Kp_00 -> "Kp_00"
  | Kp_000 -> "Kp_000"
  | Kp_1 -> "Kp_1"
  | Kp_2 -> "Kp_2"
  | Kp_3 -> "Kp_3"
  | Kp_4 -> "Kp_4"
  | Kp_5 -> "Kp_5"
  | Kp_6 -> "Kp_6"
  | Kp_7 -> "Kp_7"
  | Kp_8 -> "Kp_8"
  | Kp_9 -> "Kp_9"
  | Kp_a -> "Kp_a"
  | Kp_ampersand -> "Kp_ampersand"
  | Kp_at -> "Kp_at"
  | Kp_b -> "Kp_b"
  | Kp_backspace -> "Kp_backspace"
  | Kp_binary -> "Kp_binary"
  | Kp_c -> "Kp_c"
  | Kp_clear -> "Kp_clear"
  | Kp_clearentry -> "Kp_clearentry"
  | Kp_colon -> "Kp_colon"
  | Kp_comma -> "Kp_comma"
  | Kp_d -> "Kp_d"
  | Kp_dblampersand -> "Kp_dblampersand"
  | Kp_dblverticalbar -> "Kp_dblverticalbar"
  | Kp_decimal -> "Kp_decimal"
  | Kp_divide -> "Kp_divide"
  | Kp_e -> "Kp_e"
  | Kp_enter -> "Kp_enter"
  | Kp_equals -> "Kp_equals"
  | Kp_equalsas400 -> "Kp_equalsas400"
  | Kp_exclam -> "Kp_exclam"
  | Kp_f -> "Kp_f"
  | Kp_greater -> "Kp_greater"
  | Kp_hash -> "Kp_hash"
  | Kp_hexadecimal -> "Kp_hexadecimal"
  | Kp_leftbrace -> "Kp_leftbrace"
  | Kp_leftparen -> "Kp_leftparen"
  | Kp_less -> "Kp_less"
  | Kp_memadd -> "Kp_memadd"
  | Kp_memclear -> "Kp_memclear"
  | Kp_memdivide -> "Kp_memdivide"
  | Kp_memmultiply -> "Kp_memmultiply"
  | Kp_memrecall -> "Kp_memrecall"
  | Kp_memstore -> "Kp_memstore"
  | Kp_memsubtract -> "Kp_memsubtract"
  | Kp_minus -> "Kp_minus"
  | Kp_multiply -> "Kp_multiply"
  | Kp_octal -> "Kp_octal"
  | Kp_percent -> "Kp_percent"
  | Kp_period -> "Kp_period"
  | Kp_plus -> "Kp_plus"
  | Kp_plusminus -> "Kp_plusminus"
  | Kp_power -> "Kp_power"
  | Kp_rightbrace -> "Kp_rightbrace"
  | Kp_rightparen -> "Kp_rightparen"
  | Kp_space -> "Kp_space"
  | Kp_tab -> "Kp_tab"
  | Kp_verticalbar -> "Kp_verticalbar"
  | Kp_xor -> "Kp_xor"
  | L -> "L"
  | Lalt -> "Lalt"
  | Lang1 -> "Lang1"
  | Lang2 -> "Lang2"
  | Lang3 -> "Lang3"
  | Lang4 -> "Lang4"
  | Lang5 -> "Lang5"
  | Lang6 -> "Lang6"
  | Lang7 -> "Lang7"
  | Lang8 -> "Lang8"
  | Lang9 -> "Lang9"
  | Lctrl -> "Lctrl"
  | Left -> "Left"
  | Leftbracket -> "Leftbracket"
  | Lgui -> "Lgui"
  | Lshift -> "Lshift"
  | M -> "M"
  | Mail -> "Mail"
  | Mediaselect -> "Mediaselect"
  | Menu -> "Menu"
  | Minus -> "Minus"
  | Mode -> "Mode"
  | Mute -> "Mute"
  | N -> "N"
  | Nonusbackslash -> "Nonusbackslash"
  | Nonushash -> "Nonushash"
  | Numlockclear -> "Numlockclear"
  | O -> "O"
  | Oper -> "Oper"
  | Out -> "Out"
  | P -> "P"
  | Pagedown -> "Pagedown"
  | Pageup -> "Pageup"
  | Paste -> "Paste"
  | Pause -> "Pause"
  | Period -> "Period"
  | Power -> "Power"
  | Printscreen -> "Printscreen"
  | Prior -> "Prior"
  | Q -> "Q"
  | R -> "R"
  | Ralt -> "Ralt"
  | Rctrl -> "Rctrl"
  | Return -> "Return"
  | Return2 -> "Return2"
  | Rgui -> "Rgui"
  | Right -> "Right"
  | Rightbracket -> "Rightbracket"
  | Rshift -> "Rshift"
  | S -> "S"
  | Scrolllock -> "Scrolllock"
  | Select -> "Select"
  | Semicolon -> "Semicolon"
  | Separator -> "Separator"
  | Slash -> "Slash"
  | Sleep -> "Sleep"
  | Space -> "Space"
  | Stop -> "Stop"
  | Sysreq -> "Sysreq"
  | T -> "T"
  | Tab -> "Tab"
  | Thousandsseparator -> "Thousandsseparator"
  | U -> "U"
  | Undo -> "Undo"
  | Unknown -> "Unknown"
  | Up -> "Up"
  | V -> "V"
  | Volumedown -> "Volumedown"
  | Volumeup -> "Volumeup"
  | W -> "W"
  | Www -> "Www"
  | X -> "X"
  | Y -> "Y"
  | Z -> "Z"

(** Reverse of [show]. *)
let parse = function
  | "A" -> Some A
  | "Ac_back" -> Some Ac_back
  | "Ac_bookmarks" -> Some Ac_bookmarks
  | "Ac_forward" -> Some Ac_forward
  | "Ac_home" -> Some Ac_home
  | "Ac_refresh" -> Some Ac_refresh
  | "Ac_search" -> Some Ac_search
  | "Ac_stop" -> Some Ac_stop
  | "Again" -> Some Again
  | "Alterase" -> Some Alterase
  | "Apostrophe" -> Some Apostrophe
  | "App1" -> Some App1
  | "App2" -> Some App2
  | "Application" -> Some Application
  | "Audiomute" -> Some Audiomute
  | "Audionext" -> Some Audionext
  | "Audioplay" -> Some Audioplay
  | "Audioprev" -> Some Audioprev
  | "Audiostop" -> Some Audiostop
  | "B" -> Some B
  | "Backslash" -> Some Backslash
  | "Backspace" -> Some Backspace
  | "Brightnessdown" -> Some Brightnessdown
  | "Brightnessup" -> Some Brightnessup
  | "C" -> Some C
  | "Calculator" -> Some Calculator
  | "Cancel" -> Some Cancel
  | "Capslock" -> Some Capslock
  | "Clear" -> Some Clear
  | "Clearagain" -> Some Clearagain
  | "Comma" -> Some Comma
  | "Computer" -> Some Computer
  | "Copy" -> Some Copy
  | "Crsel" -> Some Crsel
  | "Currencysubunit" -> Some Currencysubunit
  | "Currencyunit" -> Some Currencyunit
  | "Cut" -> Some Cut
  | "D" -> Some D
  | "Decimalseparator" -> Some Decimalseparator
  | "Delete" -> Some Delete
  | "Displayswitch" -> Some Displayswitch
  | "Down" -> Some Down
  | "E" -> Some E
  | "Eject" -> Some Eject
  | "End" -> Some End
  | "Equals" -> Some Equals
  | "Escape" -> Some Escape
  | "Execute" -> Some Execute
  | "Exsel" -> Some Exsel
  | "F" -> Some F
  | "F1" -> Some F1
  | "F10" -> Some F10
  | "F11" -> Some F11
  | "F12" -> Some F12
  | "F13" -> Some F13
  | "F14" -> Some F14
  | "F15" -> Some F15
  | "F16" -> Some F16
  | "F17" -> Some F17
  | "F18" -> Some F18
  | "F19" -> Some F19
  | "F2" -> Some F2
  | "F20" -> Some F20
  | "F21" -> Some F21
  | "F22" -> Some F22
  | "F23" -> Some F23
  | "F24" -> Some F24
  | "F3" -> Some F3
  | "F4" -> Some F4
  | "F5" -> Some F5
  | "F6" -> Some F6
  | "F7" -> Some F7
  | "F8" -> Some F8
  | "F9" -> Some F9
  | "Find" -> Some Find
  | "G" -> Some G
  | "Grave" -> Some Grave
  | "H" -> Some H
  | "Help" -> Some Help
  | "Home" -> Some Home
  | "I" -> Some I
  | "Insert" -> Some Insert
  | "International1" -> Some International1
  | "International2" -> Some International2
  | "International3" -> Some International3
  | "International4" -> Some International4
  | "International5" -> Some International5
  | "International6" -> Some International6
  | "International7" -> Some International7
  | "International8" -> Some International8
  | "International9" -> Some International9
  | "J" -> Some J
  | "K" -> Some K
  | "K0" -> Some K0
  | "K1" -> Some K1
  | "K2" -> Some K2
  | "K3" -> Some K3
  | "K4" -> Some K4
  | "K5" -> Some K5
  | "K6" -> Some K6
  | "K7" -> Some K7
  | "K8" -> Some K8
  | "K9" -> Some K9
  | "Kbdillumdown" -> Some Kbdillumdown
  | "Kbdillumtoggle" -> Some Kbdillumtoggle
  | "Kbdillumup" -> Some Kbdillumup
  | "Kp_0" -> Some Kp_0
  | "Kp_00" -> Some Kp_00
  | "Kp_000" -> Some Kp_000
  | "Kp_1" -> Some Kp_1
  | "Kp_2" -> Some Kp_2
  | "Kp_3" -> Some Kp_3
  | "Kp_4" -> Some Kp_4
  | "Kp_5" -> Some Kp_5
  | "Kp_6" -> Some Kp_6
  | "Kp_7" -> Some Kp_7
  | "Kp_8" -> Some Kp_8
  | "Kp_9" -> Some Kp_9
  | "Kp_a" -> Some Kp_a
  | "Kp_ampersand" -> Some Kp_ampersand
  | "Kp_at" -> Some Kp_at
  | "Kp_b" -> Some Kp_b
  | "Kp_backspace" -> Some Kp_backspace
  | "Kp_binary" -> Some Kp_binary
  | "Kp_c" -> Some Kp_c
  | "Kp_clear" -> Some Kp_clear
  | "Kp_clearentry" -> Some Kp_clearentry
  | "Kp_colon" -> Some Kp_colon
  | "Kp_comma" -> Some Kp_comma
  | "Kp_d" -> Some Kp_d
  | "Kp_dblampersand" -> Some Kp_dblampersand
  | "Kp_dblverticalbar" -> Some Kp_dblverticalbar
  | "Kp_decimal" -> Some Kp_decimal
  | "Kp_divide" -> Some Kp_divide
  | "Kp_e" -> Some Kp_e
  | "Kp_enter" -> Some Kp_enter
  | "Kp_equals" -> Some Kp_equals
  | "Kp_equalsas400" -> Some Kp_equalsas400
  | "Kp_exclam" -> Some Kp_exclam
  | "Kp_f" -> Some Kp_f
  | "Kp_greater" -> Some Kp_greater
  | "Kp_hash" -> Some Kp_hash
  | "Kp_hexadecimal" -> Some Kp_hexadecimal
  | "Kp_leftbrace" -> Some Kp_leftbrace
  | "Kp_leftparen" -> Some Kp_leftparen
  | "Kp_less" -> Some Kp_less
  | "Kp_memadd" -> Some Kp_memadd
  | "Kp_memclear" -> Some Kp_memclear
  | "Kp_memdivide" -> Some Kp_memdivide
  | "Kp_memmultiply" -> Some Kp_memmultiply
  | "Kp_memrecall" -> Some Kp_memrecall
  | "Kp_memstore" -> Some Kp_memstore
  | "Kp_memsubtract" -> Some Kp_memsubtract
  | "Kp_minus" -> Some Kp_minus
  | "Kp_multiply" -> Some Kp_multiply
  | "Kp_octal" -> Some Kp_octal
  | "Kp_percent" -> Some Kp_percent
  | "Kp_period" -> Some Kp_period
  | "Kp_plus" -> Some Kp_plus
  | "Kp_plusminus" -> Some Kp_plusminus
  | "Kp_power" -> Some Kp_power
  | "Kp_rightbrace" -> Some Kp_rightbrace
  | "Kp_rightparen" -> Some Kp_rightparen
  | "Kp_space" -> Some Kp_space
  | "Kp_tab" -> Some Kp_tab
  | "Kp_verticalbar" -> Some Kp_verticalbar
  | "Kp_xor" -> Some Kp_xor
  | "L" -> Some L
  | "Lalt" -> Some Lalt
  | "Lang1" -> Some Lang1
  | "Lang2" -> Some Lang2
  | "Lang3" -> Some Lang3
  | "Lang4" -> Some Lang4
  | "Lang5" -> Some Lang5
  | "Lang6" -> Some Lang6
  | "Lang7" -> Some Lang7
  | "Lang8" -> Some Lang8
  | "Lang9" -> Some Lang9
  | "Lctrl" -> Some Lctrl
  | "Left" -> Some Left
  | "Leftbracket" -> Some Leftbracket
  | "Lgui" -> Some Lgui
  | "Lshift" -> Some Lshift
  | "M" -> Some M
  | "Mail" -> Some Mail
  | "Mediaselect" -> Some Mediaselect
  | "Menu" -> Some Menu
  | "Minus" -> Some Minus
  | "Mode" -> Some Mode
  | "Mute" -> Some Mute
  | "N" -> Some N
  | "Nonusbackslash" -> Some Nonusbackslash
  | "Nonushash" -> Some Nonushash
  | "Numlockclear" -> Some Numlockclear
  | "O" -> Some O
  | "Oper" -> Some Oper
  | "Out" -> Some Out
  | "P" -> Some P
  | "Pagedown" -> Some Pagedown
  | "Pageup" -> Some Pageup
  | "Paste" -> Some Paste
  | "Pause" -> Some Pause
  | "Period" -> Some Period
  | "Power" -> Some Power
  | "Printscreen" -> Some Printscreen
  | "Prior" -> Some Prior
  | "Q" -> Some Q
  | "R" -> Some R
  | "Ralt" -> Some Ralt
  | "Rctrl" -> Some Rctrl
  | "Return" -> Some Return
  | "Return2" -> Some Return2
  | "Rgui" -> Some Rgui
  | "Right" -> Some Right
  | "Rightbracket" -> Some Rightbracket
  | "Rshift" -> Some Rshift
  | "S" -> Some S
  | "Scrolllock" -> Some Scrolllock
  | "Select" -> Some Select
  | "Semicolon" -> Some Semicolon
  | "Separator" -> Some Separator
  | "Slash" -> Some Slash
  | "Sleep" -> Some Sleep
  | "Space" -> Some Space
  | "Stop" -> Some Stop
  | "Sysreq" -> Some Sysreq
  | "T" -> Some T
  | "Tab" -> Some Tab
  | "Thousandsseparator" -> Some Thousandsseparator
  | "U" -> Some U
  | "Undo" -> Some Undo
  | "Unknown" -> Some Unknown
  | "Up" -> Some Up
  | "V" -> Some V
  | "Volumedown" -> Some Volumedown
  | "Volumeup" -> Some Volumeup
  | "W" -> Some W
  | "Www" -> Some Www
  | "X" -> Some X
  | "Y" -> Some Y
  | "Z" -> Some Z
  | _ -> None
