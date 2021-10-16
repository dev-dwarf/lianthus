/// @description
lifetime--;
if (lifetime < 0) instance_destroy();

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle - oCamera.angle, c_white, 1.0);