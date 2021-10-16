/// @description

// Inherit the parent event
event_inherited();

x = floor(x);
y = floor(y);

if (global.dark[room]) {
	sprite_index = sBoyDark;	
	if (get_data("shadow_defeated", false)) instance_destroy();
}

if room == rField {
	dialogue_instance = noone;
	text_index = 0;
	
	if (get_data("shadow_defeated", false)) {
		text[0] = get_text_by_index(120);text_speed[0]	= 0.23;	 text_voice[0]	= sndBoyVoice1;
		text[1] = get_text_by_index(121);text_speed[1]	= 0.22;	 text_voice[1]	= sndBoyVoice1;
	} else if (get_data("dog_defeated", false)) {
		text[0] = get_text_by_index(40);text_speed[0]	= 0.23;	 text_voice[0]	= sndBoyVoice1;
		text[1] = get_text_by_index(41);text_speed[1]	= 0.22;	 text_voice[1]	= sndBoyVoice1;
	} else if (get_data("dash", false)) {
		text[0] = get_text_by_index(37);text_speed[0]	= 0.23;	 text_voice[0]	= sndBoyVoice1;
		text[1] = get_text_by_index(38);text_speed[1]	= 0.22;	 text_voice[1]	= sndBoyVoice1;
		text[2] = get_text_by_index(39);text_speed[2]	= 0.26;	 text_voice[2]	= sndBoyVoice1;
	} else {
		text[0] = get_text_by_index(32);text_speed[0]	= 0.22;	 text_voice[0]	= sndBoyVoice1;
		text[1] = get_text_by_index(33);text_speed[1]	= 0.24;	 text_voice[1]	= sndBoyVoice1;
		text[2] = get_text_by_index(34);text_speed[2]	= 0.27;	 text_voice[2]	= sndBoyVoice1;
		text[3] = get_text_by_index(35);text_speed[3]	= 0.30;	 text_voice[3]	= sndBoyVoice1;
		text[4] = get_text_by_index(36);text_speed[4]	= 0.22;	 text_voice[4]	= sndBoyVoice1;
	}
	text_complete = get_data("said: " + text[0] + string(room), false);
	
	fade_time = 150;
	auto_click_delay = 210;
}

if room == rFieldDark {
		dialogue_instance = noone;
	text_index = 0;
	
	text[0] = get_text_by_index(42);text_speed[0]	= 0.25;	 text_voice[0]	= sndBoyVoiceDark;
	text[1] = get_text_by_index(43);text_speed[1]	= 0.22;	 text_voice[1]	= sndBoyVoiceDark;
	text_complete = get_data("said: " + text[0] + string(room), false);
	
	fade_time = 150;
	auto_click_delay = 210;
}

