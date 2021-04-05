open Tsdl

module Code =
struct
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
    | Ampersand
    | Application
    | Asterisk
    | At
    | Audiomute
    | Audionext
    | Audioplay
    | Audioprev
    | Audiostop
    | B
    | Backquote
    | Backslash
    | Backspace
    | Brightnessdown
    | Brightnessup
    | C
    | Calculator
    | Cancel
    | Capslock
    | Caret
    | Clear
    | Clearagain
    | Colon
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
    | Dollar
    | Down
    | E
    | Eject
    | Equals
    | Escape
    | Exclaim
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
    | Greater
    | H
    | Hash
    | Help
    | Home
    | I
    | Insert
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
    | Kend
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
    | Lctrl
    | Left
    | Leftbracket
    | Leftparen
    | Less
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
    | Numlockclear
    | O
    | Oper
    | Out
    | P
    | Pagedown
    | Pageup
    | Paste
    | Pause
    | Percent
    | Period
    | Plus
    | Power
    | Printscreen
    | Prior
    | Q
    | Question
    | Quote
    | Quotedbl
    | R
    | Ralt
    | Rctrl
    | Return
    | Return2
    | Rgui
    | Right
    | Rightbracket
    | Rightparen
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
    | Underscore
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

  let compare = (Stdlib.compare: t -> t -> int)

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
    | Ampersand -> "Ampersand"
    | Application -> "Application"
    | Asterisk -> "Asterisk"
    | At -> "At"
    | Audiomute -> "Audiomute"
    | Audionext -> "Audionext"
    | Audioplay -> "Audioplay"
    | Audioprev -> "Audioprev"
    | Audiostop -> "Audiostop"
    | B -> "B"
    | Backquote -> "Backquote"
    | Backslash -> "Backslash"
    | Backspace -> "Backspace"
    | Brightnessdown -> "Brightnessdown"
    | Brightnessup -> "Brightnessup"
    | C -> "C"
    | Calculator -> "Calculator"
    | Cancel -> "Cancel"
    | Capslock -> "Capslock"
    | Caret -> "Caret"
    | Clear -> "Clear"
    | Clearagain -> "Clearagain"
    | Colon -> "Colon"
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
    | Dollar -> "Dollar"
    | Down -> "Down"
    | E -> "E"
    | Eject -> "Eject"
    | Equals -> "Equals"
    | Escape -> "Escape"
    | Exclaim -> "Exclaim"
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
    | Greater -> "Greater"
    | H -> "H"
    | Hash -> "Hash"
    | Help -> "Help"
    | Home -> "Home"
    | I -> "I"
    | Insert -> "Insert"
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
    | Kend -> "Kend"
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
    | Lctrl -> "Lctrl"
    | Left -> "Left"
    | Leftbracket -> "Leftbracket"
    | Leftparen -> "Leftparen"
    | Less -> "Less"
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
    | Numlockclear -> "Numlockclear"
    | O -> "O"
    | Oper -> "Oper"
    | Out -> "Out"
    | P -> "P"
    | Pagedown -> "Pagedown"
    | Pageup -> "Pageup"
    | Paste -> "Paste"
    | Pause -> "Pause"
    | Percent -> "Percent"
    | Period -> "Period"
    | Plus -> "Plus"
    | Power -> "Power"
    | Printscreen -> "Printscreen"
    | Prior -> "Prior"
    | Q -> "Q"
    | Question -> "Question"
    | Quote -> "Quote"
    | Quotedbl -> "Quotedbl"
    | R -> "R"
    | Ralt -> "Ralt"
    | Rctrl -> "Rctrl"
    | Return -> "Return"
    | Return2 -> "Return2"
    | Rgui -> "Rgui"
    | Right -> "Right"
    | Rightbracket -> "Rightbracket"
    | Rightparen -> "Rightparen"
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
    | Underscore -> "Underscore"
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
    | "Ampersand" -> Some Ampersand
    | "Application" -> Some Application
    | "Asterisk" -> Some Asterisk
    | "At" -> Some At
    | "Audiomute" -> Some Audiomute
    | "Audionext" -> Some Audionext
    | "Audioplay" -> Some Audioplay
    | "Audioprev" -> Some Audioprev
    | "Audiostop" -> Some Audiostop
    | "B" -> Some B
    | "Backquote" -> Some Backquote
    | "Backslash" -> Some Backslash
    | "Backspace" -> Some Backspace
    | "Brightnessdown" -> Some Brightnessdown
    | "Brightnessup" -> Some Brightnessup
    | "C" -> Some C
    | "Calculator" -> Some Calculator
    | "Cancel" -> Some Cancel
    | "Capslock" -> Some Capslock
    | "Caret" -> Some Caret
    | "Clear" -> Some Clear
    | "Clearagain" -> Some Clearagain
    | "Colon" -> Some Colon
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
    | "Dollar" -> Some Dollar
    | "Down" -> Some Down
    | "E" -> Some E
    | "Eject" -> Some Eject
    | "Equals" -> Some Equals
    | "Escape" -> Some Escape
    | "Exclaim" -> Some Exclaim
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
    | "Greater" -> Some Greater
    | "H" -> Some H
    | "Hash" -> Some Hash
    | "Help" -> Some Help
    | "Home" -> Some Home
    | "I" -> Some I
    | "Insert" -> Some Insert
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
    | "Kend" -> Some Kend
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
    | "Lctrl" -> Some Lctrl
    | "Left" -> Some Left
    | "Leftbracket" -> Some Leftbracket
    | "Leftparen" -> Some Leftparen
    | "Less" -> Some Less
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
    | "Numlockclear" -> Some Numlockclear
    | "O" -> Some O
    | "Oper" -> Some Oper
    | "Out" -> Some Out
    | "P" -> Some P
    | "Pagedown" -> Some Pagedown
    | "Pageup" -> Some Pageup
    | "Paste" -> Some Paste
    | "Pause" -> Some Pause
    | "Percent" -> Some Percent
    | "Period" -> Some Period
    | "Plus" -> Some Plus
    | "Power" -> Some Power
    | "Printscreen" -> Some Printscreen
    | "Prior" -> Some Prior
    | "Q" -> Some Q
    | "Question" -> Some Question
    | "Quote" -> Some Quote
    | "Quotedbl" -> Some Quotedbl
    | "R" -> Some R
    | "Ralt" -> Some Ralt
    | "Rctrl" -> Some Rctrl
    | "Return" -> Some Return
    | "Return2" -> Some Return2
    | "Rgui" -> Some Rgui
    | "Right" -> Some Right
    | "Rightbracket" -> Some Rightbracket
    | "Rightparen" -> Some Rightparen
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
    | "Underscore" -> Some Underscore
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
end

module Scan =
struct
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

  let compare = (Stdlib.compare: t -> t -> int)

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
end

type t =
  {
    scan: Scan.t;
    code: Code.t;
  }

let scan key =
  key.scan

let code key =
  key.code

let scan_list =
  [
    Sdl.Scancode.a, (A: Scan.t);
    Sdl.Scancode.ac_back, Ac_back;
    Sdl.Scancode.ac_bookmarks, Ac_bookmarks;
    Sdl.Scancode.ac_forward, Ac_forward;
    Sdl.Scancode.ac_home, Ac_home;
    Sdl.Scancode.ac_refresh, Ac_refresh;
    Sdl.Scancode.ac_search, Ac_search;
    Sdl.Scancode.ac_stop, Ac_stop;
    Sdl.Scancode.again, Again;
    Sdl.Scancode.alterase, Alterase;
    Sdl.Scancode.apostrophe, Apostrophe;
    Sdl.Scancode.app1, App1;
    Sdl.Scancode.app2, App2;
    Sdl.Scancode.application, Application;
    Sdl.Scancode.audiomute, Audiomute;
    Sdl.Scancode.audionext, Audionext;
    Sdl.Scancode.audioplay, Audioplay;
    Sdl.Scancode.audioprev, Audioprev;
    Sdl.Scancode.audiostop, Audiostop;
    Sdl.Scancode.b, B;
    Sdl.Scancode.backslash, Backslash;
    Sdl.Scancode.backspace, Backspace;
    Sdl.Scancode.brightnessdown, Brightnessdown;
    Sdl.Scancode.brightnessup, Brightnessup;
    Sdl.Scancode.c, C;
    Sdl.Scancode.calculator, Calculator;
    Sdl.Scancode.cancel, Cancel;
    Sdl.Scancode.capslock, Capslock;
    Sdl.Scancode.clear, Clear;
    Sdl.Scancode.clearagain, Clearagain;
    Sdl.Scancode.comma, Comma;
    Sdl.Scancode.computer, Computer;
    Sdl.Scancode.copy, Copy;
    Sdl.Scancode.crsel, Crsel;
    Sdl.Scancode.currencysubunit, Currencysubunit;
    Sdl.Scancode.currencyunit, Currencyunit;
    Sdl.Scancode.cut, Cut;
    Sdl.Scancode.d, D;
    Sdl.Scancode.decimalseparator, Decimalseparator;
    Sdl.Scancode.delete, Delete;
    Sdl.Scancode.displayswitch, Displayswitch;
    Sdl.Scancode.down, Down;
    Sdl.Scancode.e, E;
    Sdl.Scancode.eject, Eject;
    Sdl.Scancode.kend, End;
    Sdl.Scancode.equals, Equals;
    Sdl.Scancode.escape, Escape;
    Sdl.Scancode.execute, Execute;
    Sdl.Scancode.exsel, Exsel;
    Sdl.Scancode.f, F;
    Sdl.Scancode.f1, F1;
    Sdl.Scancode.f10, F10;
    Sdl.Scancode.f11, F11;
    Sdl.Scancode.f12, F12;
    Sdl.Scancode.f13, F13;
    Sdl.Scancode.f14, F14;
    Sdl.Scancode.f15, F15;
    Sdl.Scancode.f16, F16;
    Sdl.Scancode.f17, F17;
    Sdl.Scancode.f18, F18;
    Sdl.Scancode.f19, F19;
    Sdl.Scancode.f2, F2;
    Sdl.Scancode.f20, F20;
    Sdl.Scancode.f21, F21;
    Sdl.Scancode.f22, F22;
    Sdl.Scancode.f23, F23;
    Sdl.Scancode.f24, F24;
    Sdl.Scancode.f3, F3;
    Sdl.Scancode.f4, F4;
    Sdl.Scancode.f5, F5;
    Sdl.Scancode.f6, F6;
    Sdl.Scancode.f7, F7;
    Sdl.Scancode.f8, F8;
    Sdl.Scancode.f9, F9;
    Sdl.Scancode.find, Find;
    Sdl.Scancode.g, G;
    Sdl.Scancode.grave, Grave;
    Sdl.Scancode.h, H;
    Sdl.Scancode.help, Help;
    Sdl.Scancode.home, Home;
    Sdl.Scancode.i, I;
    Sdl.Scancode.insert, Insert;
    Sdl.Scancode.international1, International1;
    Sdl.Scancode.international2, International2;
    Sdl.Scancode.international3, International3;
    Sdl.Scancode.international4, International4;
    Sdl.Scancode.international5, International5;
    Sdl.Scancode.international6, International6;
    Sdl.Scancode.international7, International7;
    Sdl.Scancode.international8, International8;
    Sdl.Scancode.international9, International9;
    Sdl.Scancode.j, J;
    Sdl.Scancode.k, K;
    Sdl.Scancode.k0, K0;
    Sdl.Scancode.k1, K1;
    Sdl.Scancode.k2, K2;
    Sdl.Scancode.k3, K3;
    Sdl.Scancode.k4, K4;
    Sdl.Scancode.k5, K5;
    Sdl.Scancode.k6, K6;
    Sdl.Scancode.k7, K7;
    Sdl.Scancode.k8, K8;
    Sdl.Scancode.k9, K9;
    Sdl.Scancode.kbdillumdown, Kbdillumdown;
    Sdl.Scancode.kbdillumtoggle, Kbdillumtoggle;
    Sdl.Scancode.kbdillumup, Kbdillumup;
    Sdl.Scancode.kp_0, Kp_0;
    Sdl.Scancode.kp_00, Kp_00;
    Sdl.Scancode.kp_000, Kp_000;
    Sdl.Scancode.kp_1, Kp_1;
    Sdl.Scancode.kp_2, Kp_2;
    Sdl.Scancode.kp_3, Kp_3;
    Sdl.Scancode.kp_4, Kp_4;
    Sdl.Scancode.kp_5, Kp_5;
    Sdl.Scancode.kp_6, Kp_6;
    Sdl.Scancode.kp_7, Kp_7;
    Sdl.Scancode.kp_8, Kp_8;
    Sdl.Scancode.kp_9, Kp_9;
    Sdl.Scancode.kp_a, Kp_a;
    Sdl.Scancode.kp_ampersand, Kp_ampersand;
    Sdl.Scancode.kp_at, Kp_at;
    Sdl.Scancode.kp_b, Kp_b;
    Sdl.Scancode.kp_backspace, Kp_backspace;
    Sdl.Scancode.kp_binary, Kp_binary;
    Sdl.Scancode.kp_c, Kp_c;
    Sdl.Scancode.kp_clear, Kp_clear;
    Sdl.Scancode.kp_clearentry, Kp_clearentry;
    Sdl.Scancode.kp_colon, Kp_colon;
    Sdl.Scancode.kp_comma, Kp_comma;
    Sdl.Scancode.kp_d, Kp_d;
    Sdl.Scancode.kp_dblampersand, Kp_dblampersand;
    Sdl.Scancode.kp_dblverticalbar, Kp_dblverticalbar;
    Sdl.Scancode.kp_decimal, Kp_decimal;
    Sdl.Scancode.kp_divide, Kp_divide;
    Sdl.Scancode.kp_e, Kp_e;
    Sdl.Scancode.kp_enter, Kp_enter;
    Sdl.Scancode.kp_equals, Kp_equals;
    Sdl.Scancode.kp_equalsas400, Kp_equalsas400;
    Sdl.Scancode.kp_exclam, Kp_exclam;
    Sdl.Scancode.kp_f, Kp_f;
    Sdl.Scancode.kp_greater, Kp_greater;
    Sdl.Scancode.kp_hash, Kp_hash;
    Sdl.Scancode.kp_hexadecimal, Kp_hexadecimal;
    Sdl.Scancode.kp_leftbrace, Kp_leftbrace;
    Sdl.Scancode.kp_leftparen, Kp_leftparen;
    Sdl.Scancode.kp_less, Kp_less;
    Sdl.Scancode.kp_memadd, Kp_memadd;
    Sdl.Scancode.kp_memclear, Kp_memclear;
    Sdl.Scancode.kp_memdivide, Kp_memdivide;
    Sdl.Scancode.kp_memmultiply, Kp_memmultiply;
    Sdl.Scancode.kp_memrecall, Kp_memrecall;
    Sdl.Scancode.kp_memstore, Kp_memstore;
    Sdl.Scancode.kp_memsubtract, Kp_memsubtract;
    Sdl.Scancode.kp_minus, Kp_minus;
    Sdl.Scancode.kp_multiply, Kp_multiply;
    Sdl.Scancode.kp_octal, Kp_octal;
    Sdl.Scancode.kp_percent, Kp_percent;
    Sdl.Scancode.kp_period, Kp_period;
    Sdl.Scancode.kp_plus, Kp_plus;
    Sdl.Scancode.kp_plusminus, Kp_plusminus;
    Sdl.Scancode.kp_power, Kp_power;
    Sdl.Scancode.kp_rightbrace, Kp_rightbrace;
    Sdl.Scancode.kp_rightparen, Kp_rightparen;
    Sdl.Scancode.kp_space, Kp_space;
    Sdl.Scancode.kp_tab, Kp_tab;
    Sdl.Scancode.kp_verticalbar, Kp_verticalbar;
    Sdl.Scancode.kp_xor, Kp_xor;
    Sdl.Scancode.l, L;
    Sdl.Scancode.lalt, Lalt;
    Sdl.Scancode.lang1, Lang1;
    Sdl.Scancode.lang2, Lang2;
    Sdl.Scancode.lang3, Lang3;
    Sdl.Scancode.lang4, Lang4;
    Sdl.Scancode.lang5, Lang5;
    Sdl.Scancode.lang6, Lang6;
    Sdl.Scancode.lang7, Lang7;
    Sdl.Scancode.lang8, Lang8;
    Sdl.Scancode.lang9, Lang9;
    Sdl.Scancode.lctrl, Lctrl;
    Sdl.Scancode.left, Left;
    Sdl.Scancode.leftbracket, Leftbracket;
    Sdl.Scancode.lgui, Lgui;
    Sdl.Scancode.lshift, Lshift;
    Sdl.Scancode.m, M;
    Sdl.Scancode.mail, Mail;
    Sdl.Scancode.mediaselect, Mediaselect;
    Sdl.Scancode.menu, Menu;
    Sdl.Scancode.minus, Minus;
    Sdl.Scancode.mode, Mode;
    Sdl.Scancode.mute, Mute;
    Sdl.Scancode.n, N;
    Sdl.Scancode.nonusbackslash, Nonusbackslash;
    Sdl.Scancode.nonushash, Nonushash;
    Sdl.Scancode.numlockclear, Numlockclear;
    Sdl.Scancode.o, O;
    Sdl.Scancode.oper, Oper;
    Sdl.Scancode.out, Out;
    Sdl.Scancode.p, P;
    Sdl.Scancode.pagedown, Pagedown;
    Sdl.Scancode.pageup, Pageup;
    Sdl.Scancode.paste, Paste;
    Sdl.Scancode.pause, Pause;
    Sdl.Scancode.period, Period;
    (* Sdl.Scancode.power, Power; *) (* TODO *)
    Sdl.Scancode.printscreen, Printscreen;
    Sdl.Scancode.prior, Prior;
    Sdl.Scancode.q, Q;
    Sdl.Scancode.r, R;
    Sdl.Scancode.ralt, Ralt;
    Sdl.Scancode.rctrl, Rctrl;
    Sdl.Scancode.return, Return;
    Sdl.Scancode.return2, Return2;
    Sdl.Scancode.rgui, Rgui;
    Sdl.Scancode.right, Right;
    Sdl.Scancode.rightbracket, Rightbracket;
    Sdl.Scancode.rshift, Rshift;
    Sdl.Scancode.s, S;
    Sdl.Scancode.scrolllock, Scrolllock;
    Sdl.Scancode.select, Select;
    Sdl.Scancode.semicolon, Semicolon;
    Sdl.Scancode.separator, Separator;
    Sdl.Scancode.slash, Slash;
    Sdl.Scancode.sleep, Sleep;
    Sdl.Scancode.space, Space;
    Sdl.Scancode.stop, Stop;
    Sdl.Scancode.sysreq, Sysreq;
    Sdl.Scancode.t, T;
    Sdl.Scancode.tab, Tab;
    Sdl.Scancode.thousandsseparator, Thousandsseparator;
    Sdl.Scancode.u, U;
    Sdl.Scancode.undo, Undo;
    Sdl.Scancode.unknown, Unknown;
    Sdl.Scancode.up, Up;
    Sdl.Scancode.v, V;
    Sdl.Scancode.volumedown, Volumedown;
    Sdl.Scancode.volumeup, Volumeup;
    Sdl.Scancode.w, W;
    Sdl.Scancode.www, Www;
    Sdl.Scancode.x, X;
    Sdl.Scancode.y, Y;
    Sdl.Scancode.z, Z;
  ]

let code_list =
  [
    Sdl.K.a, (A: Code.t);
    Sdl.K.ac_back, Ac_back;
    Sdl.K.ac_bookmarks, Ac_bookmarks;
    Sdl.K.ac_forward, Ac_forward;
    Sdl.K.ac_home, Ac_home;
    Sdl.K.ac_refresh, Ac_refresh;
    Sdl.K.ac_search, Ac_search;
    Sdl.K.ac_stop, Ac_stop;
    Sdl.K.again, Again;
    Sdl.K.alterase, Alterase;
    Sdl.K.ampersand, Ampersand;
    Sdl.K.application, Application;
    Sdl.K.asterisk, Asterisk;
    Sdl.K.at, At;
    Sdl.K.audiomute, Audiomute;
    Sdl.K.audionext, Audionext;
    Sdl.K.audioplay, Audioplay;
    Sdl.K.audioprev, Audioprev;
    Sdl.K.audiostop, Audiostop;
    Sdl.K.b, B;
    Sdl.K.backquote, Backquote;
    Sdl.K.backslash, Backslash;
    Sdl.K.backspace, Backspace;
    Sdl.K.brightnessdown, Brightnessdown;
    Sdl.K.brightnessup, Brightnessup;
    Sdl.K.c, C;
    Sdl.K.calculator, Calculator;
    Sdl.K.cancel, Cancel;
    Sdl.K.capslock, Capslock;
    Sdl.K.caret, Caret;
    Sdl.K.clear, Clear;
    Sdl.K.clearagain, Clearagain;
    Sdl.K.colon, Colon;
    Sdl.K.comma, Comma;
    Sdl.K.computer, Computer;
    Sdl.K.copy, Copy;
    Sdl.K.crsel, Crsel;
    Sdl.K.currencysubunit, Currencysubunit;
    Sdl.K.currencyunit, Currencyunit;
    Sdl.K.cut, Cut;
    Sdl.K.d, D;
    Sdl.K.decimalseparator, Decimalseparator;
    Sdl.K.delete, Delete;
    Sdl.K.displayswitch, Displayswitch;
    Sdl.K.dollar, Dollar;
    Sdl.K.down, Down;
    Sdl.K.e, E;
    Sdl.K.eject, Eject;
    Sdl.K.equals, Equals;
    Sdl.K.escape, Escape;
    Sdl.K.exclaim, Exclaim;
    Sdl.K.execute, Execute;
    Sdl.K.exsel, Exsel;
    Sdl.K.f, F;
    Sdl.K.f1, F1;
    Sdl.K.f10, F10;
    Sdl.K.f11, F11;
    Sdl.K.f12, F12;
    Sdl.K.f13, F13;
    Sdl.K.f14, F14;
    Sdl.K.f15, F15;
    Sdl.K.f16, F16;
    Sdl.K.f17, F17;
    Sdl.K.f18, F18;
    Sdl.K.f19, F19;
    Sdl.K.f2, F2;
    Sdl.K.f20, F20;
    Sdl.K.f21, F21;
    Sdl.K.f22, F22;
    Sdl.K.f23, F23;
    Sdl.K.f24, F24;
    Sdl.K.f3, F3;
    Sdl.K.f4, F4;
    Sdl.K.f5, F5;
    Sdl.K.f6, F6;
    Sdl.K.f7, F7;
    Sdl.K.f8, F8;
    Sdl.K.f9, F9;
    Sdl.K.find, Find;
    Sdl.K.g, G;
    Sdl.K.greater, Greater;
    Sdl.K.h, H;
    Sdl.K.hash, Hash;
    Sdl.K.help, Help;
    Sdl.K.home, Home;
    Sdl.K.i, I;
    Sdl.K.insert, Insert;
    Sdl.K.j, J;
    Sdl.K.k, K;
    Sdl.K.k0, K0;
    Sdl.K.k1, K1;
    Sdl.K.k2, K2;
    Sdl.K.k3, K3;
    Sdl.K.k4, K4;
    Sdl.K.k5, K5;
    Sdl.K.k6, K6;
    Sdl.K.k7, K7;
    Sdl.K.k8, K8;
    Sdl.K.k9, K9;
    Sdl.K.kbdillumdown, Kbdillumdown;
    Sdl.K.kbdillumtoggle, Kbdillumtoggle;
    Sdl.K.kbdillumup, Kbdillumup;
    Sdl.K.kend, Kend;
    Sdl.K.kp_0, Kp_0;
    Sdl.K.kp_00, Kp_00;
    Sdl.K.kp_000, Kp_000;
    Sdl.K.kp_1, Kp_1;
    Sdl.K.kp_2, Kp_2;
    Sdl.K.kp_3, Kp_3;
    Sdl.K.kp_4, Kp_4;
    Sdl.K.kp_5, Kp_5;
    Sdl.K.kp_6, Kp_6;
    Sdl.K.kp_7, Kp_7;
    Sdl.K.kp_8, Kp_8;
    Sdl.K.kp_9, Kp_9;
    Sdl.K.kp_a, Kp_a;
    Sdl.K.kp_ampersand, Kp_ampersand;
    Sdl.K.kp_at, Kp_at;
    Sdl.K.kp_b, Kp_b;
    Sdl.K.kp_backspace, Kp_backspace;
    Sdl.K.kp_binary, Kp_binary;
    Sdl.K.kp_c, Kp_c;
    Sdl.K.kp_clear, Kp_clear;
    Sdl.K.kp_clearentry, Kp_clearentry;
    Sdl.K.kp_colon, Kp_colon;
    Sdl.K.kp_comma, Kp_comma;
    Sdl.K.kp_d, Kp_d;
    Sdl.K.kp_dblampersand, Kp_dblampersand;
    Sdl.K.kp_dblverticalbar, Kp_dblverticalbar;
    Sdl.K.kp_decimal, Kp_decimal;
    Sdl.K.kp_divide, Kp_divide;
    Sdl.K.kp_e, Kp_e;
    Sdl.K.kp_enter, Kp_enter;
    Sdl.K.kp_equals, Kp_equals;
    Sdl.K.kp_equalsas400, Kp_equalsas400;
    Sdl.K.kp_exclam, Kp_exclam;
    Sdl.K.kp_f, Kp_f;
    Sdl.K.kp_greater, Kp_greater;
    Sdl.K.kp_hash, Kp_hash;
    Sdl.K.kp_hexadecimal, Kp_hexadecimal;
    Sdl.K.kp_leftbrace, Kp_leftbrace;
    Sdl.K.kp_leftparen, Kp_leftparen;
    Sdl.K.kp_less, Kp_less;
    Sdl.K.kp_memadd, Kp_memadd;
    Sdl.K.kp_memclear, Kp_memclear;
    Sdl.K.kp_memdivide, Kp_memdivide;
    Sdl.K.kp_memmultiply, Kp_memmultiply;
    Sdl.K.kp_memrecall, Kp_memrecall;
    Sdl.K.kp_memstore, Kp_memstore;
    Sdl.K.kp_memsubtract, Kp_memsubtract;
    Sdl.K.kp_minus, Kp_minus;
    Sdl.K.kp_multiply, Kp_multiply;
    Sdl.K.kp_octal, Kp_octal;
    Sdl.K.kp_percent, Kp_percent;
    Sdl.K.kp_period, Kp_period;
    Sdl.K.kp_plus, Kp_plus;
    Sdl.K.kp_plusminus, Kp_plusminus;
    Sdl.K.kp_power, Kp_power;
    Sdl.K.kp_rightbrace, Kp_rightbrace;
    Sdl.K.kp_rightparen, Kp_rightparen;
    Sdl.K.kp_space, Kp_space;
    Sdl.K.kp_tab, Kp_tab;
    Sdl.K.kp_verticalbar, Kp_verticalbar;
    Sdl.K.kp_xor, Kp_xor;
    Sdl.K.l, L;
    Sdl.K.lalt, Lalt;
    Sdl.K.lctrl, Lctrl;
    Sdl.K.left, Left;
    Sdl.K.leftbracket, Leftbracket;
    Sdl.K.leftparen, Leftparen;
    Sdl.K.less, Less;
    Sdl.K.lgui, Lgui;
    Sdl.K.lshift, Lshift;
    Sdl.K.m, M;
    Sdl.K.mail, Mail;
    Sdl.K.mediaselect, Mediaselect;
    Sdl.K.menu, Menu;
    Sdl.K.minus, Minus;
    Sdl.K.mode, Mode;
    Sdl.K.mute, Mute;
    Sdl.K.n, N;
    Sdl.K.numlockclear, Numlockclear;
    Sdl.K.o, O;
    Sdl.K.oper, Oper;
    Sdl.K.out, Out;
    Sdl.K.p, P;
    Sdl.K.pagedown, Pagedown;
    Sdl.K.pageup, Pageup;
    Sdl.K.paste, Paste;
    Sdl.K.pause, Pause;
    Sdl.K.percent, Percent;
    Sdl.K.period, Period;
    Sdl.K.plus, Plus;
    Sdl.K.power, Power;
    Sdl.K.printscreen, Printscreen;
    Sdl.K.prior, Prior;
    Sdl.K.q, Q;
    Sdl.K.question, Question;
    Sdl.K.quote, Quote;
    Sdl.K.quotedbl, Quotedbl;
    Sdl.K.r, R;
    Sdl.K.ralt, Ralt;
    Sdl.K.rctrl, Rctrl;
    Sdl.K.return, Return;
    Sdl.K.return2, Return2;
    Sdl.K.rgui, Rgui;
    Sdl.K.right, Right;
    Sdl.K.rightbracket, Rightbracket;
    Sdl.K.rightparen, Rightparen;
    Sdl.K.rshift, Rshift;
    Sdl.K.s, S;
    Sdl.K.scrolllock, Scrolllock;
    Sdl.K.select, Select;
    Sdl.K.semicolon, Semicolon;
    Sdl.K.separator, Separator;
    Sdl.K.slash, Slash;
    Sdl.K.sleep, Sleep;
    Sdl.K.space, Space;
    Sdl.K.stop, Stop;
    Sdl.K.sysreq, Sysreq;
    Sdl.K.t, T;
    Sdl.K.tab, Tab;
    Sdl.K.thousandsseparator, Thousandsseparator;
    Sdl.K.u, U;
    Sdl.K.underscore, Underscore;
    Sdl.K.undo, Undo;
    Sdl.K.unknown, Unknown;
    Sdl.K.up, Up;
    Sdl.K.v, V;
    Sdl.K.volumedown, Volumedown;
    Sdl.K.volumeup, Volumeup;
    Sdl.K.w, W;
    Sdl.K.www, Www;
    Sdl.K.x, X;
    Sdl.K.y, Y;
    Sdl.K.z, Z;
  ]

module Int_map = Map.Make (Int)

module Scan_set = Set.Make (Scan)
module Scan_map = Map.Make (Scan)

module Code_set = Set.Make (Code)
module Code_map = Map.Make (Code)

let sdl_to_scan =
  let add acc (sdl, fungame) = Int_map.add sdl fungame acc in
  List.fold_left add Int_map.empty scan_list

let scan_to_sdl =
  let add acc (sdl, fungame) = Scan_map.add fungame sdl acc in
  List.fold_left add Scan_map.empty scan_list

let scan_of_sdl sdl =
  match Int_map.find sdl sdl_to_scan with
    | exception Not_found ->
        Scan.Unknown
    | x ->
        x

let sdl_of_scan fungame =
  match Scan_map.find fungame scan_to_sdl with
    | exception Not_found ->
        Sdl.Scancode.unknown
    | x ->
        x

let sdl_to_code =
  let add acc (sdl, fungame) = Int_map.add sdl fungame acc in
  List.fold_left add Int_map.empty code_list

let code_to_sdl =
  let add acc (sdl, fungame) = Code_map.add fungame sdl acc in
  List.fold_left add Code_map.empty code_list

let code_of_sdl sdl =
  match Int_map.find sdl sdl_to_code with
    | exception Not_found ->
        Code.Unknown
    | x ->
        x

let sdl_of_code fungame =
  match Code_map.find fungame code_to_sdl with
    | exception Not_found ->
        Sdl.K.unknown
    | x ->
        x

let of_scan (scan: Scan.t): t =
  {
    scan;
    code =
      scan
      |> sdl_of_scan
      |> Sdl.get_key_from_scancode
      |> code_of_sdl;
  }

let of_code (code: Code.t): t =
  {
    scan =
      code
      |> sdl_of_code
      |> Sdl.get_scancode_from_key
      |> scan_of_sdl;
    code;
  }

let of_sdl (scan: Sdl.scancode) (code: Sdl.keycode): t =
  {
    scan = scan_of_sdl scan;
    code = code_of_sdl code;
  }

let pressed = ref Scan_set.empty

let down (key: t) =
  pressed := Scan_set.add (scan key) !pressed

let up (key: t) =
  pressed := Scan_set.remove (scan key) !pressed

let is_down (key: t) =
  Scan_set.mem (scan key) !pressed
