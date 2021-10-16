/// @description
var palette = clamp(showing_palette + (oPlayer.image_index >= 2), 0, ds_list_size(global.palettes) -1);
var palette_grid = global.palettes[| palette];
	
draw_billboarded_sprite(sPaletteShadow, oPlayer.image_index, x, y, 0, image_xscale - .15 * dsin(oPlayer.image_index * 90), image_yscale, 0, c_white, 1.0);	
	
shader_set(shdPaletteSwap);
for (var i = 0; i <= 7; i++) {
	shader_set_uniform_f(oCamera.palette_uniforms[| i], palette_grid[# i, 0]/255.0, palette_grid[# i, 1]/255.0, palette_grid[# i, 2]/255.0);
}

draw_billboarded_sprite(sprite_index, oPlayer.image_index, x, y, 10 + 2 * dsin(oPlayer.image_index * 90), image_xscale, image_yscale, 0, c_white, 1.0);

shader_reset();

if (LEVEL_EDITOR_ENABLED and oLevelEditor.editor_open) {
	draw_sprite_ext(sCamera, oPlayer.image_index, x, y, 1.0, 1.0, image_angle, c_white, 1.0);
}