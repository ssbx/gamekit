open CamlSDL2
open Shared

type t = {
  texture: Sdl.Texture.t;
}

let create ?(fmt = Sdl.PixelFormat.RGBA8888) ~width ~height () =
  let tex = Sdl.create_texture (rdr ())
    ~fmt
    ~access:Sdl.TextureAccess.Target
    ~width
    ~height in
  Sdl.set_texture_blend_mode tex Sdl.BlendMode.BLEND;
  tex

let clear tex (color : Sdl.Color.t) =
  let r = rdr () in
  Sdl.set_render_target r (Some tex.texture);
  Sdl.set_render_draw_color r ~r:color.r ~g:color.g ~b:color.b ~a:color.a;
  Sdl.render_clear r
