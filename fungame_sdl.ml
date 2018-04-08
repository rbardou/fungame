open Tsdl

let (>>=) x f =
  match x with
    | Error (`Msg e) ->
        Sdl.log "SDL error: %s" e;
        Sdl.quit ();
        exit 1
    | Ok x ->
        f x

module Window =
struct
  type t =
    {
      mutable window: Sdl.window option;
      mutable renderer: Sdl.renderer option;
      w: int;
      h: int;
    }

  let create ?(title = "Fungame") ?(w = 640) ?(h = 480) () =
    (* Initialize SDL. *)
    Sdl.init Sdl.Init.video >>= fun () ->
    Tsdl_ttf.Ttf.init () >>= fun () ->
    (* fullscreen_desktop seems broken with older versions of SDL… *)
    Sdl.create_window title ~w ~h
      Sdl.Window.(opengl (* + fullscreen_desktop *)) >>= fun window ->
    Sdl.create_renderer window >>= fun renderer ->
    Sdl.render_set_logical_size renderer w h >>= fun () ->
    {
      window = Some window;
      renderer = Some renderer;
      w;
      h;
    }

  let close window =
    (
      match window.window with
        | None ->
            ()
        | Some w ->
            Sdl.destroy_window w;
            window.window <- None
    );
    (
      match window.renderer with
        | None ->
            ()
        | Some r ->
            Sdl.destroy_renderer r;
            window.renderer <- None
    )

  let renderer window =
    match window.renderer with
      | None ->
          failwith "window has been closed"
      | Some renderer ->
          renderer

end

module Scan_code = Fungame_scan_code
module Key_code = Fungame_key_code

module Key =
struct
  type scan_code = Scan_code.t
  type key_code = Key_code.t

  type t =
    {
      scan_code: scan_code;
      key_code: key_code;
    }

  let show key =
    Key_code.show key.key_code

  let show_scan_code key =
    Scan_code.show key.scan_code

  let scan_code key =
    key.scan_code

  let key_code key =
    key.key_code

  module Int =
  struct
    type t = int
    let compare = (Pervasives.compare: int -> int -> int)
  end

  module Int_map = Map.Make (Int)
  module Scan_code_map = Map.Make (Scan_code)
  module Key_code_map = Map.Make (Key_code)

  let scan_code_list =
    [
      Sdl.Scancode.a, (A: scan_code);
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

  let key_code_list =
    [
      Sdl.K.a, (A: key_code);
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

  let sdl_to_scan_code =
    let add acc (sdl, fungame) = Int_map.add sdl fungame acc in
    List.fold_left add Int_map.empty scan_code_list

  let scan_code_to_sdl =
    let add acc (sdl, fungame) = Scan_code_map.add fungame sdl acc in
    List.fold_left add Scan_code_map.empty scan_code_list

  let scan_code_of_sdl sdl =
    match Int_map.find sdl sdl_to_scan_code with
      | exception Not_found ->
          Scan_code.Unknown
      | x ->
          x

  let sdl_of_scan_code fungame =
    match Scan_code_map.find fungame scan_code_to_sdl with
      | exception Not_found ->
          Sdl.Scancode.unknown
      | x ->
          x

  let sdl_to_key_code =
    let add acc (sdl, fungame) = Int_map.add sdl fungame acc in
    List.fold_left add Int_map.empty key_code_list

  let key_code_to_sdl =
    let add acc (sdl, fungame) = Key_code_map.add fungame sdl acc in
    List.fold_left add Key_code_map.empty key_code_list

  let key_code_of_sdl sdl =
    match Int_map.find sdl sdl_to_key_code with
      | exception Not_found ->
          Key_code.Unknown
      | x ->
          x

  let sdl_of_key_code fungame =
    match Key_code_map.find fungame key_code_to_sdl with
      | exception Not_found ->
          Sdl.K.unknown
      | x ->
          x

  let of_scan_code (scan_code: scan_code): t =
    {
      scan_code =
        scan_code;
      key_code =
        scan_code
        |> sdl_of_scan_code
        |> Sdl.get_key_from_scancode
        |> key_code_of_sdl;
    }

  let of_key_code (key_code: key_code): t =
    {
      scan_code =
        key_code
        |> sdl_of_key_code
        |> Sdl.get_scancode_from_key
        |> scan_code_of_sdl;
      key_code =
        key_code;
    }

  let of_sdl (scan_code: Sdl.scancode) (key_code: Sdl.keycode): t =
    {
      scan_code = scan_code_of_sdl scan_code;
      key_code = key_code_of_sdl key_code;
    }
end

module Image =
struct
  type t =
    {
      window: Window.t;
      mutable texture: Sdl.texture option;
      w: int;
      h: int;
    }

  let width image = image.w
  let height image = image.h

  let from_texture window texture =
    Sdl.query_texture texture >>= fun (_, _, (w, h)) ->
    {
      window;
      texture = Some texture;
      w;
      h;
    }

  let load (window: Window.t) filename =
    if not (Sys.file_exists filename) then
      failwith ("no such file: " ^ filename);
    let renderer = Window.renderer window in
    Tsdl_image.Image.load_texture renderer filename >>= fun texture ->
    from_texture window texture

  let destroy image =
    match image.texture with
      | None ->
          ()
      | Some texture ->
          Sdl.destroy_texture texture;
          image.texture <- None

  let draw ~src_x ~src_y ~w ~h ~x ~y image =
    match image.texture with
      | None ->
          failwith "image has been destroyed"
      | Some texture ->
          let renderer = Window.renderer image.window in
          let w = min w image.w in
          let h = min h image.h in
          let src = Sdl.Rect.create 0 0 w h in
          let dst = Sdl.Rect.create x y w h in
          Sdl.render_copy ~src ~dst renderer texture >>= fun () ->
          ()
end

module Font =
struct
  type t =
    {
      window: Window.t;
      mutable font: Tsdl_ttf.Ttf.font option;
    }

  let load window filename size =
    Tsdl_ttf.Ttf.open_font filename size >>= fun font ->
    {
      window;
      font = Some font;
    }

  let destroy font =
    match font.font with
      | None ->
          ()
      | Some f ->
          Tsdl_ttf.Ttf.close_font f;
          font.font <- None

  type mode =
    | Solid
    | Shaded of int * int * int * int
    | Blended
    | Wrapped of int

  let render ?(utf8 = true) ?(mode = Blended) ?(color = (0, 0, 0, 255))
      font text =
    let window = font.window in
    let renderer = Window.renderer window in
    let font =
      match font.font with
        | None ->
            failwith "font has been destroyed"
        | Some font ->
            font
    in
    let color =
      let r, g, b, a = color in
      Sdl.Color.create ~r ~g ~b ~a
    in
    (
      match utf8, mode with
        | false, Solid ->
            Tsdl_ttf.Ttf.render_text_solid font text color
        | true, Solid ->
            Tsdl_ttf.Ttf.render_utf8_solid font text color
        | false, Shaded (r, g, b, a) ->
            let bg_color = Sdl.Color.create ~r ~g ~b ~a in
            Tsdl_ttf.Ttf.render_text_shaded font text color bg_color
        | true, Shaded (r, g, b, a) ->
            let bg_color = Sdl.Color.create ~r ~g ~b ~a in
            Tsdl_ttf.Ttf.render_utf8_shaded font text color bg_color
        | false, Blended ->
            Tsdl_ttf.Ttf.render_text_blended font text color
        | true, Blended ->
            Tsdl_ttf.Ttf.render_utf8_blended font text color
        | false, Wrapped width ->
            Tsdl_ttf.Ttf.render_text_blended_wrapped font text color
              (Int32.of_int width)
        | true, Wrapped width ->
            Tsdl_ttf.Ttf.render_utf8_blended_wrapped font text color
              (Int32.of_int width)
    ) >>= fun surface ->
    Sdl.create_texture_from_surface renderer surface >>= fun texture ->
    Sdl.free_surface surface;
    Image.from_texture window texture

end

module Sound =
struct
  type t =
    {
      mutable chunk: Tsdl_mixer.Mixer.chunk option;
    }

  let initialized = ref false

  let init () =
    if not !initialized then (
      (* TODO: make those settings parameters? *)
      (* 44100 is the frequency.
         2 is the channels (count?). On my machine it seems to have no effect.
         512 is the chunk size. *)
      Tsdl_mixer.Mixer.open_audio 44100 Sdl.Audio.s16_sys 2 512 >>= fun () ->
      initialized := true
    )

  let close () =
    if !initialized then (
      Tsdl_mixer.Mixer.close_audio ();
      initialized := false
    )

  let load filename =
    init ();
    Tsdl_mixer.Mixer.load_wav filename >>= fun chunk ->
    { chunk = Some chunk }

  let destroy sound =
    match sound.chunk with
      | None ->
          ()
      | Some chunk ->
          Tsdl_mixer.Mixer.free_chunk chunk;
          sound.chunk <- None

  let play ?(loops = 0) sound =
    match sound.chunk with
      | None ->
          failwith "sound has been destroyed"
      | Some chunk ->
          (* Channel (-1) means first available channel. *)
          (* Don't die in case of error as the most likely error is that
             there are no free channels available. *)
          let _: _ result = Tsdl_mixer.Mixer.play_channel (-1) chunk loops in
          ()
end

module Widget = Fungame_widget.Make (Image)

module Main_loop =
struct
  exception Quit

  let quit () =
    raise Quit

  let draw_rect renderer ~x ~y ~w ~h ~color ~fill =
    let r, g, b, a = color in
    Sdl.set_render_draw_color renderer r g b a >>= fun () ->
    let render =
      if fill then
        Sdl.render_fill_rect
      else
        Sdl.render_draw_rect
    in
    let rect = Sdl.Rect.create x y w h in
    render renderer (Some rect) >>= fun () ->
    ()

  let run window
      ?clear
      ?(auto_close_window = true)
      ?(auto_close_sound = true)
      ?(on_key_down = fun _ -> ())
      ?(on_key_repeat = fun _ -> ())
      ?(on_key_up = fun _ -> ())
      make_ui =
    let widget_state = Widget.start () in
    let renderer = Window.renderer window in
    let { w; h }: Window.t = window in

    try
      while true do
        (
          match clear with
            | None ->
                ()
            | Some (r, g, b, a) ->
                Sdl.set_render_draw_color renderer r g b a >>= fun () ->
                Sdl.render_clear renderer >>= fun () ->
                ()
        );

        let widget = Widget.place w h (Widget.box (make_ui ())) in
        Widget.draw (draw_rect renderer) ~x: 0 ~y: 0 widget;

        Sdl.render_present renderer;

        Sdl.delay 1l;

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
            if repeat > 0 then
              on_key_repeat key
            else
              on_key_down key

          else if typ = Sdl.Event.key_up then
            let scancode = Sdl.Event.get event Sdl.Event.keyboard_scancode in
            let keycode = Sdl.Event.get event Sdl.Event.keyboard_keycode in
            let key = Key.of_sdl scancode keycode in
            on_key_up key

          else if typ = Sdl.Event.mouse_button_down then
            let x = Sdl.Event.get event Sdl.Event.mouse_button_x in
            let y = Sdl.Event.get event Sdl.Event.mouse_button_y in
            let button = Sdl.Event.get event Sdl.Event.mouse_button_button in
            let _: bool = Widget.mouse_down widget_state ~button ~x ~y widget in
            ()

          else if typ = Sdl.Event.mouse_button_up then
            let x = Sdl.Event.get event Sdl.Event.mouse_button_x in
            let y = Sdl.Event.get event Sdl.Event.mouse_button_y in
            let button = Sdl.Event.get event Sdl.Event.mouse_button_button in
            let _: bool = Widget.mouse_up widget_state ~button ~x ~y widget in
            ()

          else if typ = Sdl.Event.mouse_motion then
            let x = Sdl.Event.get event Sdl.Event.mouse_motion_x in
            let y = Sdl.Event.get event Sdl.Event.mouse_motion_y in
            let _: bool = Widget.mouse_move widget_state ~x ~y widget in
            ()

        done
      done
    with Quit ->
      if auto_close_window then Window.close window;
      if auto_close_sound then Sound.close ();
      Sdl.quit ()
end
