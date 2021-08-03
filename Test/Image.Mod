MODULE TestImage;
IMPORT Al := Allegro5Lib, AlImage := Allegro5Image,
  AlCol := Allegro5Colors, Key := Allegro5Keycodes, Log;

PROCEDURE Do*;
VAR
	timer: Al.Timer;
	queue: Al.EventQueue;
	display: Al.Display;
	event: Al.Event;
	redraw: BOOLEAN;
	done: BOOLEAN;
	color1, color2: Al.Color;
	bmp, subbmp: Al.Bitmap;
	T: SHORTREAL;
BEGIN
	IF ~Al.al_install_system(Al.allegroVersionInt, 0) THEN
		Log.String('Could not init Allegro5.'); Log.Ln
	ELSE
		Al.al_install_keyboard;
		AlImage.al_init_image_addon();
		timer := Al.al_create_timer(1 / 30);
		IF timer = NIL THEN
			Log.String('Could not create timer.'); Log.Ln
		END;
		queue := Al.al_create_event_queue();
		IF queue = NIL THEN
			Log.String('Could not create queue.'); Log.Ln
		END;
		display := Al.al_create_display(320, 200);
		IF display = NIL THEN
			Log.String('Could not create display.'); Log.Ln
		END;
		Al.al_register_event_source(queue,
			Al.al_get_keyboard_event_source());
		Al.al_register_event_source(queue,
			Al.al_get_display_event_source(display));
		Al.al_register_event_source(queue,
			Al.al_get_timer_event_source(timer));
		AlCol.MapRGB(220, 30, 10, color1);
		AlCol.MapRGB(255, 220, 0, color2);
		bmp := Al.al_load_bitmap('buildings.png');
		IF bmp = NIL THEN
			Log.String('Could not load "buildings.bmp".'); Log.Ln
		ELSE
			subbmp := Al.al_create_sub_bitmap(bmp, 0, 0, 46, 38)
		END;

		redraw := TRUE;
		done := FALSE;
		T := 0;
		Al.al_start_timer(timer);
		REPEAT
			Al.al_wait_for_event(queue, event);
			IF event.type = Al.eventTimer THEN
				redraw := TRUE
			ELSIF (event.type = Al.eventKeyDown) &
					(event.keyboard.keycode = Key.escape) OR
					(event.type = Al.eventDisplayClose) THEN
				done := TRUE;
			END;
			IF event.type = Al.eventKeyDown THEN
				Log.String('Keycode ='); Log.Int(event.keyboard.keycode); Log.Ln
			END;
			IF redraw & Al.al_is_event_queue_empty(queue) THEN
				T := T + 3.14 / 180;
				Al.al_clear_to_color(color1);
				Al.al_put_pixel(318, 1, color2);
				Al.al_draw_bitmap(bmp, 10, 10, {});
				Al.al_draw_bitmap_region(bmp,
					0, 0, 46, 38, 10, 50, {});
				Al.al_draw_scaled_rotated_bitmap(subbmp,
					46, 38, 320, 200, 2, 2, 0, {});
				Al.al_draw_scaled_rotated_bitmap(subbmp,
					46, 38, 160, 100, 2, 5, T, {});
				Al.al_flip_display();
				redraw := FALSE
			END
		UNTIL done;

		IF bmp # NIL THEN
			Al.al_destroy_bitmap(bmp);
			Al.al_destroy_bitmap(subbmp)
		END;
		Al.al_destroy_display(display);
		Al.al_destroy_timer(timer);
		Al.al_destroy_event_queue(queue)
	END
END Do;

END TestImage.