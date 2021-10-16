/// @description
for (var i = 0; i < sprite_width; i += 5) {
	for (var j = 0; j < sprite_height; j += 5) {
		if (chance(4))
		instance_create_layer(	x + lengthdir_x(i - sprite_width/2 , image_angle) - lengthdir_y(j - sprite_height/2 , image_angle),
								y + lengthdir_y(i - sprite_width/2 , image_angle) + lengthdir_x(j - sprite_height/2 , image_angle),
								layer, oDogParticle);

	}	
}	

var distance = distance_to_object(oPlayer)
if (distance < sound_max_range) {
	if (sound_id == noone) {
		sound_id = play_sound(sndDogDoor	, 20, true, 0.9, 0.0, sound_effect_volume);
	}
	
	if (global.dark[room]) {
		audio_sound_gain(sound_id, sound_effect_volume * sound_close_range/distance, 0);
	} else {
		audio_sound_gain(sound_id, sound_effect_volume * 0.5 * sound_close_range/distance, 0);			
	}
} else {
	audio_stop_sound(sound_id);
	sound_id = noone;
}