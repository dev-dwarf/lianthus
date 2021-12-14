/// @description
if (instance_exists(oPause)) exit;


if (start == 0) {
	if (audio_sound_get_gain(global.music_id) == 0 and music_volume != 0) {
		audio_sound_gain(global.music_id, music_volume, 2000);	
		play_sound(sndWitchFlight, 40, false, 1.0, 0.0, sound_effect_volume);
	}
	speed = approach(speed, 3, 0.1);

	if (x > 2000) instance_destroy();
} else {
	start--;	
}
visible = true;