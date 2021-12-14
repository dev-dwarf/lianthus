/// @description
if (global.palette != 0) {
	var palette_grid = global.palettes[| global.palette-1];
	
	shader_set(shdPaletteSwap);
	
	for (var i = 0; i <= 7; i++) {
		shader_set_uniform_f(oCamera.palette_uniforms[| i], palette_grid[# i, 0]/255.0, palette_grid[# i, 1]/255.0, palette_grid[# i, 2]/255.0);
	}
}

var c, str;
for (var i = 0; i < array_length_1d(options); i++) {
	c = underline_color;
	str = options[i]
	
	var xx = (DEFAULT_WIDTH * 0.5) * global.gui_scale;
	var yy = (DEFAULT_HEIGHT * 0.66 + (i-3) * 20 + 1 + DEFAULT_HEIGHT * (1-in_position)) * global.gui_scale;
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	
	if (selected == i) {
		switch selected {
			case 1:
				str = "« " + palette_names[global.palette] + " »";
			break;
			case 2:
			
				str += ": " + string(round(global.save_data[? "music_volume"]*100));
				str = "« " + str + " »"
			break;
			case 3:
				str += ": " + string(round(global.save_data[? "sound_effect_volume"]*100));
								str = "« " + str + " »"

			break;
			case 4:
				str += ": " + string(round(pixel_perfect));
								str = "« " + str + " »"

			break;
		}
			
	}

	c = make_color_rgb(10, 3, 13);
	draw_rectangle_color(xx-(4+string_width(str)/2)*global.gui_scale/2, yy-global.gui_scale*0.15*string_height("M"), xx+(4+string_width(str)/2)*global.gui_scale/2, yy+global.gui_scale*0.15*string_height("M"), c, c, c, c, false);
	
	
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

	draw_sprite_ext(sKeyIcon, oPlayer.image_index, 16 + 32 * 0.5 * key_gui_scale, 16 + 32 * 0.5 * key_gui_scale, abs(image_xscale) * 0.5 * key_gui_scale, image_yscale * 0.5 * key_gui_scale, 0, image_blend, image_alpha)
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	var c = make_color_rgb(35, 12, 69);
	draw_text_transformed_color(20 + 50 * 0.5 * key_gui_scale, 26 + 36 * 0.5 * key_gui_scale + key_gui_scale, string(get_data("keys", 0)), key_gui_scale,  key_gui_scale, -5 * flower_gui_scale/ global.gui_scale, c, c, c, c, 1.0);
																																				  						  
	c = make_color_rgb(255, 255, 247);																											  				  
	draw_text_transformed_color(20 + 50 * 0.5 * key_gui_scale, 26 + 36 * 0.5 * key_gui_scale, string(get_data("keys", 0)), key_gui_scale, key_gui_scale, -5 * flower_gui_scale/ global.gui_scale, c, c, c, c, 1.0);

	


	draw_sprite_ext(sSunflowerIcon1, oPlayer.image_index, display_get_gui_width() - (16 + 32 * 0.5 * key_gui_scale), 16 + 32 * 0.5  * key_gui_scale, abs(image_xscale) * 0.5 * flower_gui_scale, image_yscale * 0.5 * flower_gui_scale, 0, image_blend, image_alpha)
	
	draw_set_halign(fa_right);
	draw_set_valign(fa_bottom);
	var c = make_color_rgb(35, 12, 69);
	draw_text_transformed_color(display_get_gui_width() - (20 + 50 * 0.5 * key_gui_scale), 26 + 36 * 0.5 * key_gui_scale + key_gui_scale, string(get_data("flowers", 0)), flower_gui_scale, flower_gui_scale, 5 * flower_gui_scale/ global.gui_scale, c, c, c, c, 1.0);
																																				  						  																		
	c = make_color_rgb(255, 255, 247);																											  				  																				
	draw_text_transformed_color(display_get_gui_width() - (20 + 50 * 0.5 * key_gui_scale), 26 + 36 * 0.5 * key_gui_scale, string(get_data("flowers", 0)), flower_gui_scale, flower_gui_scale, 5 * flower_gui_scale/ global.gui_scale, c, c, c, c, 1.0);
	
if (global.palette != 0) {
	shader_reset();
}