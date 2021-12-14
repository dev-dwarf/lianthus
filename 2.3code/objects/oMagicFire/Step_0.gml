/// @description
if (active) {
	for (var i = 0; i < sprite_width; i += 8) {
		for (var j = 0; j < sprite_height; j += 8) {
			if (chance(7))
			instance_create_layer(	x + lengthdir_x(i - sprite_width/2 , image_angle) - lengthdir_y(j - sprite_height/2 , image_angle),
									y + lengthdir_y(i - sprite_width/2 , image_angle) + lengthdir_x(j - sprite_height/2 , image_angle),
									layer, oFireParticle);

		}	
	}
	
	if (collision_instance == noone) {		
		collision_instance = instance_create_layer(x,y,layer,oMagicFireHitbox);
	}
	collision_instance.sprite_index = sprite_index;
	collision_instance.image_xscale = image_xscale;
	collision_instance.image_yscale = image_yscale;				
	collision_instance.image_angle	= image_angle;		
	
	//var distance = distance_to_object(oPlayer)
	//if (distance < sound_max_range and !audio_is_playing(sndFireLoop)) {
	//	if (sound_id == noone) {
	//		sound_id = play_sound(sndFireLoop	, 20, true, 1.3, 0.0, sound_effect_volume * 0.75);
	//	}
	
	//	if (global.dark[room]) {
	//		audio_sound_gain(sound_id, 0.5 * sound_effect_volume * sound_close_range/distance, 0);
	//	} else {
	//		audio_sound_gain(sound_id, sound_effect_volume * 0.5 * sound_close_range/distance, 0);			
	//	}
	//} else {
	//	audio_stop_sound(sound_id);
	//	sound_id = noone;
	//}
} else {
	if (collision_instance != noone) {
		instance_destroy(collision_instance);	
		collision_instance = noone;
	}
}

