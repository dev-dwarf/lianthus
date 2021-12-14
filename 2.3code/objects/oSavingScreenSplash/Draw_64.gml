/// @description
if (global.palette != 0) {
	var palette_grid = global.palettes[| global.palette-1];
	
	shader_set(shdPaletteSwap);
	
	for (var i = 0; i <= 7; i++) {
		shader_set_uniform_f(palette_uniforms[| i], palette_grid[# i, 0]/255.0, palette_grid[# i, 1]/255.0, palette_grid[# i, 2]/255.0);
	}
	
//	draw_rectangle_color(0, 0, room_width, room_height, black, black, black, black, false);
}
draw_sprite_ext(sSaving, image_index, (DEFAULT_WIDTH + sprite_width)/2 * global.gui_scale, (DEFAULT_HEIGHT - sprite_width*2)/2 * global.gui_scale, global.gui_scale, global.gui_scale, image_angle, image_blend, image_alpha);

draw_set_font(sFontInternational);

draw_set_halign(fa_center);
draw_set_valign(fa_center);

draw_text_transformed_color(DEFAULT_WIDTH/2 * global.gui_scale, (DEFAULT_HEIGHT * 3/4 + 1) * global.gui_scale, text, global.gui_scale, global.gui_scale, 0, purple, purple, purple, purple, 1.0);
draw_text_transformed_color(DEFAULT_WIDTH/2 * global.gui_scale, DEFAULT_HEIGHT * 3/4 * global.gui_scale, text, global.gui_scale, global.gui_scale, 0, white, white, white, white, 1.0);

if (global.palette != 0) {
	shader_reset();
}