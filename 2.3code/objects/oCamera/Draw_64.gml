/// @description
if (global.hide_gui) exit;

if (global.palette != 0) {
	var palette_grid = global.palettes[| global.palette-1];
	
	shader_set(shdPaletteSwap);
	
	for (var i = 0; i <= 7; i++) {
		shader_set_uniform_f(palette_uniforms[| i], palette_grid[# i, 0]/255.0, palette_grid[# i, 1]/255.0, palette_grid[# i, 2]/255.0);
	}
}	

	with global.oldest_player {
	//	var c = make_color_rgb(255, 255, 247);
		
		//if (last_keys != get_data("keys", 0)) {
		//	last_keys = lerp(last_keys, get_data("keys", 0), 0.025);
	
	
		//	draw_sprite_ext(sKeyIcon, 0, (8 + 3.5) * global.gui_scale * 2, (8 + 3.5) * global.gui_scale * 2, global.gui_scale * 2, global.gui_scale * 2, 4 * dsin(current_time * 0.25), c_white, 1.0);
		//	draw_text_transformed_color((18 + 3.5 * string_length(string(get_data("keys", 0)))) * global.gui_scale * 2, (14 + 3.5) * global.gui_scale * 2, string(get_data("keys", 0)), global.gui_scale, global.gui_scale, 4 * dsin(current_time * 0.25), c, c, c, c, 1.0)
		//}// else if (last_flowers != get_data("flowers", 0)) {
		////	last_flowers = lerp(last_flowers, get_data("flowers", 0), 0.025);
	
	
		//	draw_sprite_ext(sSunflowerBits, 0, (8 + 3.5) * global.gui_scale * 2, (8 + 3.5) * global.gui_scale * 2, global.gui_scale * 2, global.gui_scale * 2, 4 * dsin(current_time * 0.25), c_white, 1.0);
		//	draw_text_transformed_color((18 + 3.5 * string_length(string(get_data("flowers", 0)))) * global.gui_scale * 2, (14 + 3.5) * global.gui_scale * 2, string(get_data("flowers", 0)), global.gui_scale, global.gui_scale, 4 * dsin(current_time * 0.25), c, c, c, c, 1.0)
		//}
		
		if (instance_exists(oShadow)) {
			var frame = 0;
			
			if (possesed) {
				if (possesed_time < possesion_complete_time/2) {
					frame = 1;	
				} else {
					frame = 2;
				}
			}
			
			var scale;
			
			for (var i = 0; i < ceil(global.oldest_player.lerped_hp); i++) {
				scale =  global.gui_scale/2 * min(global.oldest_player.lerped_hp - i, 1)
				draw_sprite_ext(sGuiSkull, frame, (4 + 32 * (i + 0.5)) * global.gui_scale/2, (4 + 16) * global.gui_scale/2, scale, scale, 0, c_white, 1.0);
			}
			
			for (var i = 0; i < ceil(oShadow.hp/oShadow.hp_threshold); i++) {
				scale =  global.gui_scale/2 * min((oShadow.hp - i * oShadow.hp_threshold)/oShadow.hp_threshold, 1)
				draw_sprite_ext(sGuiSkull, 3, DEFAULT_WIDTH * global.gui_scale - ((4 + 32 * (i + 0.5))) * global.gui_scale/2, (4 + 16) * global.gui_scale/2, scale, scale, 0, c_white, 1.0);
			}	
			
		} else 
		
		if (instance_exists(oDog) and room == rDogDark) or lerped_hp != hp {
			var scale;
			
			for (var i = 0; i < ceil(global.oldest_player.lerped_hp); i++) {
				scale =  global.gui_scale/2 * min(global.oldest_player.lerped_hp - i, 1)
				draw_sprite_ext(sGuiSkull, 0, (4 + 32 * (i + 0.5)) * global.gui_scale/2, (4 + 16) * global.gui_scale/2, scale, scale, 0, c_white, 1.0);
			}
			
			if (instance_exists(oDog)) {
				log("drawn");
				for (var i = 0; i < oDog.hp; i++) {
					draw_sprite_ext(sGuiWolf, 0, DEFAULT_WIDTH * global.gui_scale - ((4 + 32 * (i + 0.5))) * global.gui_scale/2, (4 + 16) * global.gui_scale/2, global.gui_scale/2, global.gui_scale/2, 0, c_white, 1.0);
				}
			}	
		}
	}
	
if  global.recently_saved > 0 {
	global.recently_saved--;
	draw_sprite_ext(sSaving, global.oldest_player.image_index, (DEFAULT_WIDTH - 8) * global.gui_scale, 8 * global.gui_scale, global.gui_scale, global.gui_scale, 0, c_white, 1.0);
}

if (global.palette != 0) {
	shader_reset();
	
} 

//if (!instance_exists(oLevelLoader) and room_names[room] != noone and !LEVEL_EDITOR_ENABLED) {
//	room_started--;
	
//	if (room_started > 0) {
//		draw_set_halign(fa_center);
//		var green = make_color_rgb(0, 77, 87);
//		draw_text_transformed_color(DEFAULT_WIDTH * global.gui_scale/2, (DEFAULT_HEIGHT - 20 + 1) * global.gui_scale, room_names[room], global.gui_scale, global.gui_scale, 0, green, green, green, green, 1.0);
//		var white = make_color_rgb(255, 255, 247);
//		draw_text_transformed_color(DEFAULT_WIDTH * global.gui_scale/2, (DEFAULT_HEIGHT - 20) * global.gui_scale, room_names[room], global.gui_scale, global.gui_scale, 0, white, white, white, white, 1.0);
//	}	
//}

