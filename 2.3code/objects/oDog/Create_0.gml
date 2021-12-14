/// @description

// Inherit the parent event
event_inherited();

if get_data("dog_defeated", false) {
	if (instance_exists(oOrb))
		oOrb.active = true;
	instance_destroy();		
	
	//if !audio_is_playing(sndDogDarkIntro) {
	//	play_sound(sndDogDarkIntro, 0, false, 1.0, 0.0, sound_effect_volume);
	//}
} 

instance_create_layer(0, 0, layer, oAmbiencePlayer);

wait = 30;
wait_speed = 8;

made_fire = true;


if global.dark[room] {
	
	if !audio_is_playing(sndDogDarkIntro) {
		play_sound(sndDogDarkIntro, 0, false, 1.0, 0.0, sound_effect_volume);
	}
	
	enum dog {
		chase,
		spawn,
		attack,
		vanish,
		hittable,
		fire,
		death
	}
	sprite_index = sDogDarkVanish;	
	image_speed = -1;
	state = dog.vanish;
	initial_spawn = true;
	//initial_spawn = false;

	
	chase_direction = 0;
	chase_speed_max = 1.52;
	chase_accel = 0.021;
	chase_speed = 0;
	chase_attack_count = 3// + 1 * (3-hp)
	
	attack_speed = 5.0;
	attack_decel = 0.19;
	attack_accel = 0.26;
	attack_range = 80;
	attack_timer = 240;
	attack_timer_max = 110;
	attack_hit_this_time = false;
	attack_accelerated = false;
	
	spawn_collision_instance = noone;
	spawn_timer_max = 200; // - 30 * (3-hp);
	spawn_timer = spawn_timer_max;
	
	hittable_time_max = 5 * 60;
	hittable_timer = hittable_time_max;
	
	fire_timer_max = 170;
	fire_timer = fire_timer_max;
	fire_count = 2;
	
	hp = 3;
	
	//instance_deactivate_object(oPointOfInterest);

	camera_object = instance_create_layer(x,y,layer, oPointOfInterest);
	camera_object.image_angle = -85;
	camera_object.image_xscale = 2.0;
	camera_object.image_yscale = 15.;
	
	footstep_played = false;
	
}

