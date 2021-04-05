exception SDL_error of string

let () =
  Printexc.register_printer @@ function
  | SDL_error msg -> Some ("SDL error: " ^ msg)
  | _ -> None

let (>>=) x f =
  match x with
    | Error (`Msg e) ->
        raise (SDL_error e)
    | Ok x ->
        f x
