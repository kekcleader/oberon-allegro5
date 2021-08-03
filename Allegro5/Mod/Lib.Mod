MODULE Allegro5Lib ["allegro-5.2.dll"];
IMPORT SYSTEM;
CONST
  allegroVersionInt* = 5020400H; (*version 5.2.4.0*)

  eventTimer* = 30;
  eventKeyDown* = 10;
  eventDisplayClose* = 42;
  
  (*flip flags for al_draw_bitmap*)
  flipHorizontal* = 1;
  flipVertical* = 2;

TYPE
  Color* = RECORD [untagged]
    r*, g*, b*, a*: SHORTREAL
  END;
  
  LockedRegion* = POINTER TO RECORD [untagged]
    data*: POINTER TO RECORD [untagged] END;
    format*: INTEGER;
    pitch*: INTEGER;
    pixelSize*: INTEGER
  END;

  Display* = POINTER TO RECORD [untagged] END;
  Bitmap* = POINTER TO RECORD [untagged] END;
  EventQueue* = POINTER TO RECORD [untagged] END;
  Timer* = POINTER TO RECORD [untagged] END;
  EventSource* = POINTER TO RECORD [untagged] END;
  
  DisplayEvent* = RECORD [untagged]
    type*: INTEGER; (*Wrong?*)
    source*: POINTER TO RECORD [untagged] END; (*Wrong?*)
    timestamp*: REAL; (*double?*)
    x*, y*: INTEGER;
    width*, height*: INTEGER;
    pad: ARRAY 255 OF CHAR
  END;

  KeyboardEvent* = RECORD [untagged]
    type*: INTEGER; (*Wrong?*)
    source*: POINTER TO RECORD [untagged] END; (*Wrong?*)
    timestamp*: REAL; (*double?*)
    display*: Display;
    keycode*: INTEGER;
    unichar*: INTEGER;
    modifiers*: SET; (*int? commented as bitfield*)
    repeat*: BOOLEAN;
    pad: ARRAY 255 OF CHAR
  END;

  TimerEvent* = RECORD [untagged]
    type*: INTEGER; (*Wrong?*)
    source*: POINTER TO RECORD [untagged] END; (*Wrong?*)
    timestamp*: REAL; (*double?*)
    count*: LONGINT;
    error*: REAL; (*double?*)
    pad: ARRAY 255 OF CHAR
  END;

  Event* = RECORD [union]
    type*: INTEGER;
    display*: DisplayEvent;
    keyboard*: KeyboardEvent;
    timer*: TimerEvent
  END;

(*al_init is a C-macro: al_install_system(ALLEGRO_VERSION_INT, atexit)*)
PROCEDURE [ccall16] al_install_system*(version, atexit: INTEGER): BOOLEAN;
PROCEDURE [ccall16] al_install_keyboard*();
PROCEDURE [ccall16] al_create_timer*(period: REAL (*double?*) ): Timer;
PROCEDURE [ccall16] al_create_event_queue*(): EventQueue;
PROCEDURE [ccall16] al_create_display*(w, h: INTEGER): Display;
PROCEDURE [ccall16] al_get_keyboard_event_source*(): EventSource;
PROCEDURE [ccall16] al_get_display_event_source*(display: Display): EventSource;
PROCEDURE [ccall16] al_get_timer_event_source*(timer: Timer): EventSource;
PROCEDURE [ccall16] al_start_timer*(timer: Timer);
PROCEDURE [ccall16] al_register_event_source*(queue: EventQueue; source: EventSource);
PROCEDURE [ccall16] al_wait_for_event*(queue: EventQueue; VAR event: Event);
PROCEDURE [ccall16] al_is_event_queue_empty*(queue: EventQueue): BOOLEAN;
PROCEDURE [ccall16] al_clear_to_color*(color: Color);
(*PROCEDURE [ccall16] al_map_rgb*(r, g, b: BYTE): Color; *)
PROCEDURE [ccall16] al_flip_display*();
PROCEDURE [ccall16] al_destroy_display*(display: Display);
PROCEDURE [ccall16] al_destroy_timer*(timer: Timer);
PROCEDURE [ccall16] al_destroy_event_queue*(queue: EventQueue);

PROCEDURE [ccall16] al_create_bitmap*(w, h: INTEGER): Bitmap;
PROCEDURE [ccall16] al_destroy_bitmap*(bmp: Bitmap);
PROCEDURE [ccall16] al_clone_bitmap*(bmp: Bitmap): Bitmap;
PROCEDURE [ccall16] al_get_bitmap_flags*(bmp: Bitmap): SET;
PROCEDURE [ccall16] al_get_bitmap_format*(bmp: Bitmap): INTEGER;
PROCEDURE [ccall16] al_get_bitmap_width*(bmp: Bitmap): INTEGER;
PROCEDURE [ccall16] al_get_bitmap_height*(bmp: Bitmap): INTEGER;

PROCEDURE [ccall16] al_create_sub_bitmap*(parent: Bitmap; x, y, w, h: INTEGER): Bitmap;
PROCEDURE [ccall16] al_is_sub_bitmap*(bmp: Bitmap): BOOLEAN;
PROCEDURE [ccall16] al_get_parent_bitmap*(bmp: Bitmap): Bitmap;
PROCEDURE [ccall16] al_get_bitmap_x*(bmp: Bitmap): INTEGER;
PROCEDURE [ccall16] al_get_bitmap_y*(bmp: Bitmap): INTEGER;
PROCEDURE [ccall16] al_reparent_bitmap*(bmp, parent: Bitmap; x, y, w, h: INTEGER);

PROCEDURE [ccall16] al_lock_bitmap*(bmp: Bitmap; format, flags: INTEGER): LockedRegion;
PROCEDURE [ccall16] al_lock_bitmap_region*(bmp: Bitmap; x, y, w, h, format, flags: INTEGER): LockedRegion;
PROCEDURE [ccall16] al_is_bitmap_locked*(bmp: Bitmap): BOOLEAN;
PROCEDURE [ccall16] al_unlock_bitmap*(bmp: Bitmap);

PROCEDURE [ccall16] al_convert_bitmap*(bmp: Bitmap);
PROCEDURE [ccall16] al_convert_memory_bitmaps*;
PROCEDURE [ccall16] al_is_compatible_bitmap*(bmp: Bitmap): BOOLEAN;

PROCEDURE [ccall16] al_set_new_bitmap_flags*(flags: SET);
PROCEDURE [ccall16] al_add_new_bitmap_flag*(flags: SET);
PROCEDURE [ccall16] al_get_new_bitmap_flags*(): SET;
PROCEDURE [ccall16] al_set_new_bitmap_format*(format: INTEGER);
PROCEDURE [ccall16] al_get_new_bitmap_format*(): INTEGER;

PROCEDURE [ccall16] al_draw_bitmap*(bmp: Bitmap; dx, dy: SHORTREAL; flip: SET);
PROCEDURE [ccall16] al_draw_tinted_bitmap*(bmp: Bitmap; tint: Color; dx, dy: SHORTREAL; flip: SET);
PROCEDURE [ccall16] al_draw_bitmap_region*(bmp: Bitmap; sx, sy, sw, sh, dx, dy: SHORTREAL; flip: SET);
PROCEDURE [ccall16] al_draw_tinted_bitmap_region*(bmp: Bitmap; tint: Color; sx, sy, sw, sh, dx, dy: SHORTREAL; flip: SET);
PROCEDURE [ccall16] al_draw_pixel*(bmp: Bitmap; x, y: SHORTREAL; color: Color);
PROCEDURE [ccall16] al_draw_rotated_bitmap*(bmp: Bitmap; cx, cy, dx, dy, angle: SHORTREAL; flip: SET);
PROCEDURE [ccall16] al_draw_tinted_rotated_bitmap*(bmp: Bitmap; tint: Color; cx, cy, dx, dy, angle: SHORTREAL; flip: SET);
PROCEDURE [ccall16] al_draw_scaled_rotated_bitmap*(bmp: Bitmap; cx, cy, dx, dy, xScale, yScale, angle: SHORTREAL; flip: SET);
PROCEDURE [ccall16] al_draw_tinted_scaled_rotated_bitmap*(bmp: Bitmap; tint: Color; cx, cy, dx, dy, xScale, yScale, angle: SHORTREAL; flip: SET);
PROCEDURE [ccall16] al_draw_tinted_scaled_rotated_bitmap_region*(bmp: Bitmap; sx, sy, sw, sh: SHORTREAL; tint: Color; cx, cy, dx, dy, xScale, yScale, angle: SHORTREAL; flip: SET);
PROCEDURE [ccall16] al_draw_scaled_bitmap*(bmp: Bitmap; sx, sy, sw, sh, dx, dy, dw, dh: SHORTREAL; flip: SET);
PROCEDURE [ccall16] al_draw_tinted_scaled_bitmap*(bmp: Bitmap; tint: Color; sx, sy, sw, sh, dx, dy, dw, dh: SHORTREAL; flip: SET);

PROCEDURE [ccall16] al_get_current_display*(): Display;
PROCEDURE [ccall16] al_set_target_bitmap*(bmp: Bitmap);
PROCEDURE [ccall16] al_get_target_bitmap*(): Bitmap;
PROCEDURE [ccall16] al_put_pixel*(x, y: INTEGER; c: Color);
PROCEDURE [ccall16] al_put_blended_pixel*(x, y: INTEGER; c: Color);
(*PROCEDURE [ccall16] al_get_pixel*(bmp: Bitmap; x, y: INTEGER): Color; *)

PROCEDURE [ccall16] al_hold_bitmap_drawing*(hold: BOOLEAN);
PROCEDURE [ccall16] al_is_bitmap_drawing_held*(): BOOLEAN;

PROCEDURE [ccall16] al_load_bitmap*(filename: ARRAY OF SHORTCHAR): Bitmap;
PROCEDURE [ccall16] al_load_bitmap_flags*(filename: ARRAY OF SHORTCHAR; flags: SET): Bitmap;

END Allegro5Lib.