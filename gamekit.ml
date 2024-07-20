open CamlSDL2
open CamlSDL2_mixer
module Anims = Anims
module Timer = Timer
module Spring = Spring
module Easing = Easing
module Fonts = Fonts
module Texture2D = Texture2D
module Shared = Shared

let simulate_60fps = Int.div 1000 60
let ticks : int ref = ref 0
let delta : int ref = ref 0

let rec consume_events ~handle_event =
  (* TODO retained mode style with wait_event *)
  match Sdl.poll_event () with
  | None -> ()
  | Some e ->
    handle_event e;
    consume_events ~handle_event
;;

let rec loop ~renderer ~vsync ~quit_loop ~handle_update ~handle_event ~handle_draw =
  if vsync <> true then Sdl.delay ~ms:simulate_60fps;
  let new_ticks = Sdl.get_ticks () in
  delta := new_ticks - !ticks;
  ticks := new_ticks;
  (*
     let wait =
     (Timer.length ()) = 0 &&
     (Anims.length ()) = 0 &&
     !needs_redraw = false &&
     !wait_for_events = true in*)
  Timer.update !ticks;
  Anims.update !ticks;
  consume_events ~handle_event;
  handle_update ~ticks:!ticks;
  (*if !needs_redraw then ( *)
  Sdl.render_clear renderer;
  handle_draw ~renderer;
  Sdl.render_present renderer;
  (* ); *)
  if !quit_loop = true
  then print_endline "bye!"
  else loop ~renderer ~vsync ~quit_loop ~handle_update ~handle_event ~handle_draw
;;

let init ~w ~h ~logical_w ~logical_h ~name ~font_dir =
  Sdl.init [ `SDL_INIT_VIDEO; `SDL_INIT_EVENTS; `SDL_INIT_AUDIO ];
  Mix.init [ `MIX_INIT_OGG ];
  Mix.open_audio
    ~frequency:Mix.Default.frequency
    ~audio_format:Mix.Default.audio_format
    ~channels:2
    ~chunk_size:Mix.Default.chunk_size;
  Sdl.set_hint "SDL_RENDER_SCALE_QUALITY" "2";
  Sdl.set_hint "SDL_RENDER_VSYNC" "1";
  let window =
    Sdl.create_window
      ~title:name
      ~x:`centered
      ~y:`centered
      ~width:w
      ~height:h
      ~flags:[ Sdl.WindowFlags.OpenGL; Sdl.WindowFlags.Resizable ]
  in
  let renderer =
    Sdl.create_renderer
      ~win:window
      ~index:(-1)
      ~flags:
        [ Sdl.RendererFlags.PresentVSync
        ; Sdl.RendererFlags.Accelerated
        ; Sdl.RendererFlags.TargetTexture
        ]
  in
  Sdl.render_set_scale renderer ~scaleX:4. ~scaleY:3.;
  Sdl.render_set_logical_size renderer ~width:logical_w ~height:logical_h;
  ticks := Sdl.get_ticks ();
  delta := 0;
  Sdl.set_render_draw_color renderer ~r:0 ~g:0 ~b:0 ~a:255;
  Sdl.render_clear renderer;
  Sdl.render_present renderer;
  Fonts.init font_dir;
  Shared.renderer_val := (Some renderer);
  window, renderer
;;

let release (w, r) =
  Mix.close_audio ();
  Fonts.release ();
  Sdl.destroy_renderer r;
  Sdl.destroy_window w;
  Sdl.quit ()
;;
