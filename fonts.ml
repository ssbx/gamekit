open CamlSDL2
open CamlSDL2_ttf

let fonts_dir : string ref = ref ""

let f500 : Ttf.Font.t option ref = ref None
let fg_color = Sdl.Color.make ~r:255 ~g:255 ~b:255 ~a:255

let get_f500 () =
  match !f500 with Some v -> v | None -> failwith "f500 not loaded"

let get_surface v =
  Ttf.render_text_solid
    ~font:(get_f500 ())
    ~text:v
    ~fg:fg_color

let init f_dir =
  fonts_dir := f_dir;
  Ttf.init ();
  let f = Ttf.open_font
    ~file:(Filename.concat !fonts_dir "OpenSans-Regular.ttf")
    ~ptsize:32 in
  f500 := Some f

let release () = ()
