/// @description
//image_angle += angle_speed;
if (instance_exists(oPause)) exit;


move_speed = approach(move_speed, oPlayer.bone_speed + flower_charged, 0.2 + 0.2 * flower_charged);
image_xscale = approach(image_xscale, 1.2 * sign(image_xscale), 0.1);
image_yscale = approach(image_yscale, 1.2, 0.1);

instance_deactivate_object(oPlayer);
var collided = move(move_speed, direction, false);
instance_activate_object(oPlayer);

if (collided) {
	play_sound(sndTreeHit, 20, false, 0.75, 0.2, sound_effect_volume);
	oCamera.screenshake = 0.05 ;
	instance_destroy();
}

if (flower_charged > 0) {
	if (chance(flower_charged * 20)) {
		part_particles_create(magic_particles, x + irandom_range(-4, 4), y + irandom_range(-4, 4), oPlayer.magic_particle, 1 + chance(10))	
	}
	
	if (flower_charged > 2) {
		if (chance(flower_charged * 15)) {
		part_particles_create(magic_particles, x + irandom_range(-4, 4), y + irandom_range(-4, 4), oPlayer.dark_magic_particle, 1 + chance(10))	
	}
	}
}

destroy_alarm--;
if (destroy_alarm < 0) {
	instance_destroy();
}


z = 10 + 2 * dsin(oPlayer.image_index * 90);