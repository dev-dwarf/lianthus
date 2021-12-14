/// @description

if (destroy) {
	flower_gui_scale = lerp(flower_gui_scale, 0, 0.1);
	key_gui_scale = lerp(key_gui_scale, 0, 0.1);
	in_position = lerp(in_position, 0, 0.1);
	oCamera.image_zscale = lerp(oCamera.image_zscale,prev_camera_zscale, 0.1);	
	oCamera.zscale_min = lerp(oCamera.zscale_min, 1.25, 0.1);
	
	if (in_position < 0.1) {
		instance_destroy();
		ds_map_secure_save(global.save_data, SAVEFILE);
		//global.recently_saved = 100;

	}
	
	exit;
} else {
	key_gui_scale = lerp(key_gui_scale, global.gui_scale, 0.1);
	flower_gui_scale = lerp(flower_gui_scale, global.gui_scale, 0.1);

}

oCamera.image_zscale = lerp(oCamera.image_zscale, 0.9, 0.05);	
oCamera.zscale_min = lerp(oCamera.zscale_min, 0.9, 0.05);


var move_x_axis, move_y_axis, input_direction, input_magnitude, attack_button_released, attack_button_charge, spell_button_released, spell_button_charge, dash_button_released, dash_button_charge;

if (global.gamepad_connected) {
	move_x_axis = gamepad_axis_value(global.gamepad_slot, gp_axislh) + (g_check(0, gp_padr) - g_check(0, gp_padl));
	move_y_axis = gamepad_axis_value(global.gamepad_slot, gp_axislv) + (g_check(0, gp_padd) - g_check(0, gp_padu));
	
	attack_button_released = g_check_r(global.gamepad_slot, gp_face3) or g_check_r(global.gamepad_slot, gp_shoulderrb);
	attack_button_charge = g_check(global.gamepad_slot, gp_face3) or g_check(global.gamepad_slot, gp_shoulderrb);

	var key_pause = g_check_p(global.gamepad_slot, gp_start);
} else {
	move_x_axis = check(vk_d) - check(vk_a);
	move_y_axis = check(vk_s) - check(vk_w);
	
	attack_button_released = mouse_check_button_released(mb_left) or check_r(vk_j);
	attack_button_charge = mouse_check_button(mb_left) or check(vk_j);
	
	var key_pause = check_p(vk_escape);

}

if (key_pause) destroy = true;

move_x_axis *= !(move_delay > 0);
move_y_axis *= !(move_delay > 0);

if (move_delay > 0) move_delay--;

if (abs(move_y_axis) > 0.4) {
	selected += sign(move_y_axis);
	selected = clamp(selected, 0, array_length_1d(options)-1);
	selected_boost = 0;
	move_delay = delay;
	play_sound(sndGrassFootstep, 0, false, 2.5, 0.3, sound_effect_volume);
}

if (move_x_axis != 0 and side_delay <= 0) {
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
	}
	side_delay = 12;
}
side_delay = approach(side_delay, 0, 1);

if (attack_button_released) {
	switch selected {
		case 0:
			destroy = true;
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
		case 5:
			var inst = instance_create_layer(oPlayer.x, oPlayer.y, oPlayer.layer, oLevelTransition);
			inst.target_room = rTitle;
			ds_map_secure_save(global.save_data, SAVEFILE);
			global.recently_saved = 100;
		break;
	}
	
	play_sound(sndGrassFootstep, 0, false, 1.0, 0.2, sound_effect_volume);
}

selected_boost = lerp(selected_boost, 8, 0.25);
in_position = lerp(in_position, 1.0, 0.1);


