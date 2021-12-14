/// @description
var move_x_axis, move_y_axis, input_direction, input_magnitude, attack_button_released, attack_button_charge, spell_button_released, spell_button_charge, dash_button_released, dash_button_charge;

if (global.gamepad_connected) {
	move_x_axis = gamepad_axis_value(global.gamepad_slot, gp_axislh) + (g_check(0, gp_padr) - g_check(0, gp_padl));
	move_y_axis = gamepad_axis_value(global.gamepad_slot, gp_axislv) + (g_check(0, gp_padd) - g_check(0, gp_padu));
	
	attack_button_released = g_check_p(global.gamepad_slot, gp_face3) or g_check_p(global.gamepad_slot, gp_shoulderrb);
	attack_button_charge = g_check(global.gamepad_slot, gp_face3) or g_check(global.gamepad_slot, gp_shoulderrb);

} else {
	move_x_axis = check(vk_d) - check(vk_a);
	move_y_axis = check(vk_s) - check(vk_w);
	
	attack_button_released = mouse_check_button_pressed(mb_left) or check_p(vk_j);
	attack_button_charge = mouse_check_button(mb_left) or check(vk_j);

}

move_x_axis *= !(move_delay > 0);
move_y_axis *= !(move_delay > 0);

if (move_delay > 0) move_delay--;

if (abs(move_y_axis) > 0.4) {
	selected += sign(move_y_axis);
	selected = clamp(selected, 0, array_length_2d(options, screen)-1);
	selected_boost = 0;
	move_delay = delay;
	alt_text = "";
	alt_text_length = 0;
	play_sound(sndGrassFootstep, 0, false, 2.5, 0.3, sound_effect_volume);
	
	if screen == 1 and (selected == 6 or selected == 7) {
		yes_no_index = irandom(array_length_1d(no_options)-1);	
	}
	
	if (selected - draw_index > max_draw-1) {
		draw_index = approach(draw_index, array_length_2d(options, last_screen)-max_draw, 1);		
	} else if (selected - draw_index < max_draw-1) {
		draw_index = approach(draw_index, 0, 1);	
	}
}

if (!instance_exists(oPointOfInterest)) {
	instance_create_layer(x,y,layer,oPointOfInterest);
}

switch screen {
	case 0:		
		switch selected {
			case 3:
			case 0: 
			oPointOfInterest.image_angle = lerp(oPointOfInterest.image_angle, 0, 0.09);
				break;
			case 1:
			oPointOfInterest.image_angle = lerp(oPointOfInterest.image_angle, -10, 0.09);
				break;
			case 2:
			oPointOfInterest.image_angle = lerp(oPointOfInterest.image_angle, 10, 0.09);
				break;
		}
		
		if (selected == 3) {
			oCamera.image_zscale = lerp(oCamera.image_zscale, 0.9, 0.05);	
			oCamera.zscale_min = lerp(oCamera.zscale_min, 0.9, 0.05);
		} else {
			oCamera.zscale_min = lerp(oCamera.zscale_min, 1.25, 0.05);
		}
	break;
	case 1:
		oPointOfInterest.image_angle = lerp(oPointOfInterest.image_angle, -20, 0.09);
		
	break;
	case 2:
		oPointOfInterest.image_angle = lerp(oPointOfInterest.image_angle, 180, 0.09);	
	break;
}

if (screen == 1 and move_x_axis != 0 and side_delay <= 0) {
	switch selected {
		case 1:
			global.palette += sign(move_x_axis);
	
			if (global.palette > get_data("unlocked_palettes", 0) or global.palette >= ds_list_size(global.palettes)) {
				global.palette = 0;	
			}
			if (global.palette < 0) {
				global.palette = min(get_data("unlocked_palettes", 0), ds_list_size(global.palettes)-1);
			}
				
			global.save_data[? "palette"] = global.palette;
			break;
		case 2:
			global.save_data[? "music_volume"] += 0.1 * sign(move_x_axis);	
			global.save_data[? "music_volume"] = clamp(global.save_data[? "music_volume"], 0, 1);		
			
			music_volume		= global.save_data[? "music_volume"];
				
			audio_sound_gain(global.music_id, music_volume, 0);
		break;
		case 3:
			global.save_data[? "sound_effect_volume"] += 0.1 * sign(move_x_axis);
			global.save_data[? "sound_effect_volume"] = clamp(global.save_data[? "sound_effect_volume"], 0, 1);		
			
			sound_effect_volume	= global.save_data[? "sound_effect_volume"];
		break;
		case 4:
			pixel_perfect += sign(move_x_axis);
			//if (pixel_perfect > global.gui_scale) pixel_perfect = 1;
			pixel_perfect = clamp(pixel_perfect, 1, global.gui_scale);
				
			global.save_data[? "pixel_perfect"] = pixel_perfect;
		break;
		case 5:
			global.text_language += sign(move_x_axis);
			if (global.text_language > global.max_language) global.text_language = 1;
			if (global.text_language < 1) global.text_language = global.max_language;
				
			global.save_data[? "language"] = global.text_language;
			
		//	show(string(global.text_language));
			
			#region update text
			options[0, 0] = get_text_by_index(74);
			options[0, 1] = get_text_by_index(75);
			options[0, 2] = get_text_by_index(76);
			options[0, 3] = get_text_by_index(77);

			options[1, 0] = get_text_by_index(78);
			options[1, 1] = get_text_by_index(79);
			options[1, 2] = get_text_by_index(80);
			options[1, 3] = get_text_by_index(81);
			options[1, 4] = get_text_by_index(82);
			options[1, 6] = get_text_by_index(83);
			options[1, 5] = get_text_by_index(84);
			options[1, 7] = get_text_by_index(115);
			options[1, 8] = get_text_by_index(116);

			confirmation_text = get_text_by_index(117);
									 
			options[2, 0] = get_text_by_index(78);
			options[2, 1] = "Dev Dwarf";
			options[2, 2] = "Lewmoth";
			options[2, 3] = "Nol";
			options[2, 4] = "Clovelt";

			credits_alt_text[0] = "";
			credits_alt_text[1] = "@dev_dwarf";
			credits_alt_text[2] = "@Lewmothmusic";
			credits_alt_text[3] = "@nolnad";
			credits_alt_text[4] = "@Clovelt";

			alt_text = "";
			alt_text_length = 0;

			var i = 0;
			yes_options[i++] = get_text_by_index(85)
			yes_options[i++] = get_text_by_index(86)
			yes_options[i++] = get_text_by_index(87)
			yes_options[i++] = get_text_by_index(88)
			yes_options[i++] = get_text_by_index(89)
			yes_options[i++] = get_text_by_index(90)

			var i = 0;
			no_options[i++] = get_text_by_index(91)
			no_options[i++] = get_text_by_index(92)
			no_options[i++] = get_text_by_index(93)
			no_options[i++] = get_text_by_index(94)
			no_options[i++] = get_text_by_index(95)
			no_options[i++] = get_text_by_index(96)
			
			#endregion
		break;
	}
	side_delay = 12;
}
side_delay = approach(side_delay, 0, 1);

if (attack_button_released) {
	
	if (screen == 0) {
		switch selected {
			case 0:
				var inst = instance_create_layer(oPlayer.x, oPlayer.y, oPlayer.layer, oLevelTransition);
				inst.target_room = rShrine;
				break;
			case 1:
				screen = 1;
				selected = 0;
				selected_boost = 0;
				go_away = true;
				play_sound(sndPlayerDash, 0, false, 1.75, 0.2, sound_effect_volume);
				break;
			case 2:
				screen = 2;
				selected = 0;
				selected_boost = 0;
				go_away = true;
				play_sound(sndPlayerDash, 0, false, 1.75, 0.2, sound_effect_volume);
				break;
			case 3:
				game_end();
				ds_map_secure_save(global.save_data, SAVEFILE);
				break;
		}
	} else if (screen == 1) {
		if (selected != 8) {
			delete_pressed = false;	
		}
		
		switch selected {
			case 0:
				screen = 0;
				selected = 1;
				selected_boost = 0;
				go_away = true;
				play_sound(sndPlayerDash, 0, false, 1.75, 0.2, sound_effect_volume);
				break;
			case 1:
				global.palette++;
	
				if (global.palette > get_data("unlocked_palettes", 0) or global.palette >= ds_list_size(global.palettes)) {
					global.palette = 0;	
				}
				
				global.save_data[? "palette"] = global.palette;
				break;
			case 2:
				global.save_data[? "music_volume"] += 0.1;
				
				if (global.save_data[? "music_volume"] > 1) {
					global.save_data[? "music_volume"] = 0;	
				}
			
				music_volume		= global.save_data[? "music_volume"];
				
				audio_sound_gain(global.music_id, music_volume, 0);
			break;
			case 3:
				global.save_data[? "sound_effect_volume"] += 0.1;
				
				if (global.save_data[? "sound_effect_volume"] > 1) {
					global.save_data[? "sound_effect_volume"] = 0;	
				}
			
				sound_effect_volume	= global.save_data[? "sound_effect_volume"];
			break;
			case 4:
				pixel_perfect++;
				if (pixel_perfect > global.gui_scale) pixel_perfect = 1;
				
				global.save_data[? "pixel_perfect"] = pixel_perfect;
			break;
			case 6:
			fullscreen = !fullscreen;
			global.save_data[? "fullscreen"] = fullscreen;
			
			#region resize window
			global.set_window = false
			window_set_fullscreen(fullscreen);

			//if fullscreen {
			//	scale = display_get_height()/DEFAULT_HEIGHT;
			//	window_x = (display_get_width()  - DEFAULT_WIDTH  * scale) / 2; //get centered coords
			//	window_y = (display_get_height() - DEFAULT_HEIGHT * scale) / 2;

			//	surface_resize(application_surface,DEFAULT_WIDTH*pixel_perfect,DEFAULT_HEIGHT*pixel_perfect);
			//	display_set_gui_size(DEFAULT_WIDTH*scale,DEFAULT_HEIGHT*scale);

			//	global.gui_scale = scale;
			//	if (!global.set_window) {
			//		window_set_rectangle(window_x, window_y, DEFAULT_WIDTH*scale,DEFAULT_HEIGHT*scale); // centers window
			//		global.set_window = true;
			//	}
			//} else {
			if (fullscreen == false) {
				scale = 3
				window_x = (display_get_width()  - DEFAULT_WIDTH  * scale) / 2; //get centered coords
				window_y = (display_get_height() - DEFAULT_HEIGHT * scale) / 2;

				display_set_gui_size(DEFAULT_WIDTH*scale,DEFAULT_HEIGHT*scale);
				global.gui_scale = scale;
				
				if (!global.set_window) {
					window_set_size(DEFAULT_WIDTH*scale,DEFAULT_HEIGHT*scale); // centers window
					global.set_window = true;
				}
			}
			#endregion
			break;
			case 7:
			global.hide_gui = !global.hide_gui;
			global.save_data[? "hide_gui"] = global.hide_gui;
			break;
			case 5:
				global.text_language++;
				if (global.text_language > global.max_language) global.text_language = 1;
				if (global.text_language < 1) global.text_language = global.max_language;
				
				global.save_data[? "language"] = global.text_language;
				#region update text
				options[0, 0] = get_text_by_index(74);
				options[0, 1] = get_text_by_index(75);
				options[0, 2] = get_text_by_index(76);
				options[0, 3] = get_text_by_index(77);

				options[1, 0] = get_text_by_index(78);
				options[1, 1] = get_text_by_index(79);
				options[1, 2] = get_text_by_index(80);
				options[1, 3] = get_text_by_index(81);
				options[1, 4] = get_text_by_index(82);
				options[1, 6] = get_text_by_index(83);
				options[1, 5] = get_text_by_index(84);
				options[1, 7] = get_text_by_index(115);
				options[1, 8] = get_text_by_index(116);

				confirmation_text = get_text_by_index(117);
									 
				options[2, 0] = get_text_by_index(78);
				options[2, 1] = "Dev Dwarf";
				options[2, 2] = "Lewmoth";
				options[2, 3] = "Nol";
				options[2, 4] = "Clovelt";

				credits_alt_text[0] = "";
				credits_alt_text[1] = "@dev_dwarf";
				credits_alt_text[2] = "@Lewmothmusic";
				credits_alt_text[3] = "@nolnad";
				credits_alt_text[4] = "@Clovelt";

				alt_text = "";
				alt_text_length = 0;

				var i = 0;
				yes_options[i++] = get_text_by_index(85)
				yes_options[i++] = get_text_by_index(86)
				yes_options[i++] = get_text_by_index(87)
				yes_options[i++] = get_text_by_index(88)
				yes_options[i++] = get_text_by_index(89)
				yes_options[i++] = get_text_by_index(90)

				var i = 0;
				no_options[i++] = get_text_by_index(91)
				no_options[i++] = get_text_by_index(92)
				no_options[i++] = get_text_by_index(93)
				no_options[i++] = get_text_by_index(94)
				no_options[i++] = get_text_by_index(95)
				no_options[i++] = get_text_by_index(96)
			
				#endregion
			break;
			case 8:
			if (delete_pressed == false) {
				delete_pressed = true;
			} else {
				file_delete(SAVEFILE);
				show("GATE ERASED");
				game_end();
			}
			break;
		}
	} else if (screen == 2) {
		if (selected == 0) {
			screen = 0;
				selected = 2;
				selected_boost = 0;
				go_away = true;
				play_sound(sndPlayerDash, 0, false, 1.75, 0.2, sound_effect_volume);
		}
	}
	
	if (screen == 1) {
		color = make_color_rgb(255, 0, 89);
		underline_color = make_color_rgb(10, 3, 13)	
	} else {
		color = make_color_rgb(255, 207, 0);
		underline_color = make_color_rgb(0, 77, 87)	
	}
	
	play_sound(sndGrassFootstep, 0, false, 1.0, 0.2, sound_effect_volume);
}
selected_boost = lerp(selected_boost, 8, 0.25);

if (go_away) {
	in_position = lerp(in_position, -6, 0.1);
	if (in_position < -5.6) {
		go_away = false;
		play_sound(sndPlayerDash, 0, false, 1.5, 0.2, sound_effect_volume);
		last_screen = screen;	
	}
} else {
	in_position = lerp(in_position, 1.0, 0.1);
}
