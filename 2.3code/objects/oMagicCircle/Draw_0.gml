/// @description

if (triggered) {
	draw_sprite_ext(sMagicCircleRed, oPlayer.image_index, x, y, image_xscale ,image_yscale, image_angle, image_blend, 1.0)
} else {
	draw_sprite_ext(sprite_index, oPlayer.image_index, x, y, image_xscale ,image_yscale, image_angle, image_blend, 1.0)
}

if (clone_z > 0) {
	draw_sprite_ext(sprite_index, oPlayer.image_index, x - oCamera.x_step * clone_z / oCamera.image_zscale, y - oCamera.y_step * clone_z / oCamera.image_zscale, image_xscale ,image_yscale, image_angle * 2, image_blend, 1.0)

	repeat(1) {
		var rand_z = random(clone_z)
		draw_sprite_ext(sprite_index, oPlayer.image_index, x - oCamera.x_step * rand_z / oCamera.image_zscale, y - oCamera.y_step * rand_z / oCamera.image_zscale, image_xscale ,image_yscale, image_angle * 2, image_blend, 1.0)
		
	}
}