open CamlSDL2
open CamlSDL2_ttf
open Shared

let fonts_dir : string ref = ref ""
let f500 : Ttf.Font.t option ref = ref None
let fg_color = Sdl.Color.make ~r:255 ~g:255 ~b:255 ~a:255

let get_f500 () =
  match !f500 with
  | Some v -> v
  | None -> failwith "f500 not loaded"
;;

let get_surface v = Ttf.render_text_solid ~font:(get_f500 ()) ~text:v ~fg:fg_color

let init f_dir =
  fonts_dir := f_dir;
  Ttf.init ();
  let f =
    Ttf.open_font ~file:(Filename.concat !fonts_dir "OpenSans-Regular.ttf") ~ptsize:32
  in
  f500 := Some f
;;

let gen_text text =
  let surf = get_surface text in
  let w = Sdl.get_surface_width surf
  and h = Sdl.get_surface_height surf in
  let tex = Sdl.create_texture_from_surface (rdr ()) surf in
  Sdl.free_surface surf;
  ({
    texture = tex;
    width = w;
    height = h;
  } : Texture2D.t)

;;
let release () = ()
