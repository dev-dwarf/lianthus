/// @description
var blend;
if (triggered) {
	blend = red;	
} else {
	blend = white;	
}

draw_sprite_ext(sprite_index, oPlayer.image_index, x, y, image_xscale ,image_yscale, image_angle, blend, 1.0)

if (clone_z > 0) {
	draw_sprite_ext(sprite_index, oPlayer.image_index, x - oCamera.x_step * clone_z / oCamera.image_zscale, y - oCamera.y_step * clone_z / oCamera.image_zscale, image_xscale ,image_yscale, image_angle * 2, blend, 1.0)

	repeat(2) {
		var rand_z = random(clone_z)
		draw_sprite_ext(sprite_index, oPlayer.image_index, x - oCamera.x_step * rand_z / oCamera.image_zscale, y - oCamera.y_step * rand_z / oCamera.image_zscale, image_xscale ,image_yscale, image_angle * 2, blend, 1.0)
		
	}
}