/// @description
if (shadow_defeated and !global.dark[room]) {
	shader_set(shdBird);
}

draw_billboarded_sprite(sprite_index, image_index, x, y, z-40, image_xscale, image_yscale, image_angle, image_blend, 1.0)

if (shadow_defeated and !global.dark[room]) {
	shader_reset();
}