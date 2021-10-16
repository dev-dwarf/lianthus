/// @description
if (global.palette != 0) {
	var palette_grid = global.palettes[| global.palette-1];
	
	shader_set(shdPaletteSwap);
	
	for (var i = 0; i <= 7; i++) {
		shader_set_uniform_f(oCamera.palette_uniforms[| i], palette_grid[# i, 0]/255.0, palette_grid[# i, 1]/255.0, palette_grid[# i, 2]/255.0);
	}
}

var c, str;

if (last_screen == 0) {
	//var xx = (8) * in_position * global.gui_scale;
	//var yy = (DEFAULT_HEIGHT * 0.66 - 45) * global.gui_scale;
	//draw_sprite(sLogo, 18, xx, yy);
}

for (var i = draw_index; i < array_length_2d(options, last_screen); i++) {
	c = underline_color;
	str = options[last_screen, i]
	
	if (last_screen == 0) {
		var xx = (8 + selected_boost * (selected == i)) * in_position * global.gui_scale;
		var yy = (DEFAULT_HEIGHT * 0.66 + (i-1) * 20 + 1) * global.gui_scale;
		draw_set_halign(fa_left);
		draw_set_valign(fa_center);
		
	} else if (last_screen == 1) {
		var xx = (DEFAULT_WIDTH - (8 + selected_boost * (selected == i)) * in_position) * global.gui_scale;
		var yy = (DEFAULT_HEIGHT * 0.66 + (i-4-draw_index) * 20 + 1) * global.gui_scale;
		draw_set_halign(fa_right);
		draw_set_valign(fa_center);
		
		if (selected == i) {
			switch selected {
				case 1:
					str = palette_names[global.palette];
					str = "« " + str + " »";
				break;
				case 2:
					str = "« " + str;
					str += ": " + string(round(global.save_data[? "music_volume"]*100));
					str += " »"
				break;
				case 3:
					str = "« " + str;
					str += ": " + string(round(global.save_data[? "sound_effect_volume"]*100));
					str += " »"
				break;
				case 4:
					str = "« " + str;
					str += ": " + string(round(pixel_perfect));
					str += " »"
				break;
				case 5:
					str = "« " + str + " »";
				break;
				case 6:
				if fullscreen {
					str += ": " + yes_options[yes_no_index];
				} else {		
					str += ": " + no_options[yes_no_index];
				}
				break;
				case 7:
				if global.hide_gui {
					str += ": " + yes_options[yes_no_index];
				} else {		
					str += ": " + no_options[yes_no_index];
				}
				break;
				case 8:
				if (delete_pressed) {
					str = confirmation_text;	
				}
				break;
			}
			
		}
	} else {
		var xx = (DEFAULT_WIDTH * 0.5) * global.gui_scale;
		var yy = (DEFAULT_HEIGHT * 0.66 + (i-3) * 20 + 1 + DEFAULT_HEIGHT * (1-in_position)) * global.gui_scale;
		draw_set_halign(fa_center);
		draw_set_valign(fa_center);
		if (selected == i and i != 0) {
			str = alt_text;
			
			alt_text_length = approach(alt_text_length, string_length(credits_alt_text[i]), 0.5);
			alt_text = string_copy(credits_alt_text[i], 1, floor(alt_text_length));
		}
	}
	
	if (selected == i) c = selected_underline_color;
	draw_text_ext_transformed_color(xx, 
								yy + global.gui_scale,
								str, -1, -1, global.gui_scale, global.gui_scale, 0, c, c, c, c, 1.0);
								
								
	c = color;
	if (selected == i) c = selected_color;
	draw_text_ext_transformed_color(xx, 
								yy,
								str, -1, -1, global.gui_scale, global.gui_scale, 0, c, c, c, c, 1.0);
}

if (global.palette != 0) {
	shader_reset();
}