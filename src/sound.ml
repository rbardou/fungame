open Tsdl
open Error

type t =
  {
    mutable chunk: Tsdl_mixer.Mixer.chunk option;
  }

let initialized = ref false

let init ?(channel_count = 64) () =
  if not !initialized then (
    (* TODO: make those settings parameters? *)
    (* 44100 is the frequency.
       2 is the channel count (stereo).
       512 is the chunk size. *)
    Tsdl_mixer.Mixer.open_audio 44100 Sdl.Audio.s16_sys 2 512 >>= fun () ->
    let _: int = Tsdl_mixer.Mixer.allocate_channels 0 channel_count in
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
