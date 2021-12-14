/// @description

draw_sprite_ext(sNoisyBug, image_index, x, y, image_xscale, image_yscale, move_direction - draw_direction_offset, c_white, 1.0);

for (var i = 0; i < 4; i++) {
	draw_sprite_ext(sNoisyBugPaw, image_index, x - lengthdir_x(sprite_width * 0.8, move_direction - draw_direction_offset - i * 25 - angle_offsets[i]), y - lengthdir_y(sprite_width * 0.8, move_direction - draw_direction_offset - i * 25 - angle_offsets[i]), image_xscale, image_yscale, move_direction - draw_direction_offset, c_white, 1.0);
}

for (var i = 0; i < 4; i++) {
	draw_sprite_ext(sNoisyBugPaw, image_index, x + lengthdir_x(sprite_width * 0.8, move_direction - draw_direction_offset - i * 25 - angle_offsets[i]), y + lengthdir_y(sprite_width * 0.8, move_direction - draw_direction_offset - i * 25 - angle_offsets[i]), image_xscale, image_yscale, move_direction - draw_direction_offset, c_white, 1.0);
}