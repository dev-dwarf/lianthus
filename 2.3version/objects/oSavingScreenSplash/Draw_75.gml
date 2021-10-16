/// @description
if (index <= 0.1) {
	exit;
}

if (global.palette != 0) {
	var palette_grid = global.palettes[| global.palette-1];
	
	shader_set(shdPaletteSwap);
	
	for (var i = 0; i <= 7; i++) {
		shader_set_uniform_f(palette_uniforms[| i], palette_grid[# i, 0]/255.0, palette_grid[# i, 1]/255.0, palette_grid[# i, 2]/255.0);
	}
}

draw_sprite_ext(sTransition, clamp(index, 0, 8), DEFAULT_WIDTH * global.gui_scale/2, 0, global.gui_scale, global.gui_scale, 0, c_white, 1.0);
draw_sprite_ext(sTransition, clamp(index, 0, 8), DEFAULT_WIDTH * global.gui_scale/2, DEFAULT_HEIGHT * global.gui_scale, global.gui_scale, global.gui_scale * -1, 0, c_white, 1.0);
index -= 0.15;;
	


if (global.palette != 0) {
	shader_reset();
}