///@desc play_sound
function play_sound() {
	var _sound		= argument[0];///@param id
	var _priority	= argument[1];///@param priority
	var _loop		= argument[2];///@param loops

	// optional params
	var _id = audio_play_sound(_sound, _priority, _loop);

	var _modify_pitch = argument_count > 3;
	if (_modify_pitch) {
		var _pitch			= argument[3];///@param pitch?
		var _pitch_variance	= argument[4]/10;///@param variance?
		audio_sound_pitch(_id, _pitch + random_range(-_pitch_variance, _pitch_variance))	
	}

	var _modify_gain = argument_count > 5;
	if (_modify_gain) {	
		var _gain = argument[5];  ///@param gain?
		audio_sound_gain(_id, _gain, 0);
	}

	return _id;


}
