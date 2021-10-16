/// @description

if (global.palette != 0) {
	var palette_grid = global.palettes[| global.palette-1];
	
	shader_set(shdPaletteSwap);
	
	for (var i = 0; i <= 7; i++) {
		shader_set_uniform_f(palette_uniforms[| i], palette_grid[# i, 0]/255.0, palette_grid[# i, 1]/255.0, palette_grid[# i, 2]/255.0);
	}
	
	draw_surface_ext(application_surface, 0, 0, global.gui_scale/global.pixel_perfect, global.gui_scale/global.pixel_perfect, 0, c_white, 1.0);

	shader_reset();
}