/// @description
event_inherited();
has_fought = get_data("has_fought_dog", false);

active = false;
dog_spawned = false;
angle_speed = 0;
if (has_fought) {
	particle_timer = 20;	
} else {
	particle_timer = 6 * 60;
}


z = -5000;

magic_circles = part_system_create(); part_system_depth(magic_circles, -3000);
magic_circle = part_type_create();
part_type_sprite(magic_circle, sMagicCircle, true, false, false);
part_type_orientation(magic_circle, 0, 359, 5, 0, true);
part_type_life(magic_circle, 15, 40);
part_type_size(magic_circle, 0.4, 1.0, -0.02, 0);
	
dark_particle = part_type_create();
part_type_sprite(dark_particle, sDarkParticle, true, true, false);
part_type_orientation(dark_particle, 0, 359, 5, 0, true);
part_type_life(dark_particle, 15, 40);
part_type_size(dark_particle, 0.75, 1.5, -0.03, 0);

image_blend = make_color_rgb(255, 255, 247);

finished = get_data("dog_defeated", false);

if (finished) {
	image_xscale = 0.5;
	image_yscale = 0.5;
	image_blend = make_color_rgb(255, 0, 89);
}