open CamlSDL2
open Shared

type t = {
  texture: Sdl.Texture.t;
  width: int;
  height: int;
}

let clear_white : Sdl.Color.t = {r=0;g=0;b=0;a=0}

let create ?(fmt = Sdl.PixelFormat.RGBA8888) width height =
  let tex = Sdl.create_texture (rdr ())
    ~fmt
    ~access:Sdl.TextureAccess.Target
    ~width
    ~height in
  Sdl.set_texture_blend_mode tex Sdl.BlendMode.BLEND;
  { texture = tex
  ; width = width
  ; height = height
  }


let clear_with_color tex ~r ~g ~b ~a =
  let rend = rdr () in
  Sdl.set_render_target rend (Some tex.texture);
  Sdl.set_render_draw_color rend ~r ~g ~b ~a;
  Sdl.render_clear rend

let clear tex = clear_with_color tex
  ~r:clear_white.r ~g:clear_white.g ~b:clear_white.b ~a:clear_white.a
let draw_begin tex =
  Sdl.set_render_target (rdr ()) (Some tex.texture)

let draw_end _tex =
  Sdl.set_render_target (rdr ()) None

let copy tex dstrect =
  Sdl.render_copy (rdr ()) ~texture:tex.texture ~srcrect:None ~dstrect:(Some dstrect)

let destroy tex =
  Sdl.destroy_texture tex.texture
