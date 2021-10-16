/// @description
if (room == rShrineDark)
	audio_stop_all();
global.music_index = snd;
global.music_id = play_sound(snd, 1, true, 1.0, 0.0, music_volume)
audio_sound_gain(global.music_id, 0, 0);
audio_sound_gain(global.music_id, music_volume, 1500);