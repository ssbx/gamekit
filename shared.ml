open CamlSDL2

let renderer_val : Sdl.Renderer.t option ref = ref None

let rdr () =
  match !renderer_val with
  | None -> failwith "no renderer_val"
  | Some r -> r
