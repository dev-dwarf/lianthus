/// @description

// Inherit the parent event
event_inherited();

x = floor(x);
y = floor(y);

if (global.dark[room]) {
	sprite_index = sRogueDark;	
	
	if (get_data("shadow_defeated", false)) instance_destroy();
	
	text[0] = get_text_by_index(97);text_speed[0]	= 0.20;	 text_voice[0]	= sndRogueDarkVoice;
	text[1] = get_text_by_index(98);text_speed[1]	= 0.23;	 text_voice[1]	= sndRogueDarkVoice;
	text[2] = get_text_by_index(99);text_speed[2]	= 0.23;	 text_voice[2]	= sndRogueDarkVoice;
	text[3] = get_text_by_index(100);text_speed[3]	= 0.20;	 text_voice[3]	= sndRogueDarkVoice;
} else {	
	if (get_data("shadow_defeated", false)) {
		sprite_index = sRogueDead
		text[0] = get_text_by_index(110);text_speed[0]	= 0.20;	 text_voice[0]	= sndRogueVoice1;
		text[1] = get_text_by_index(111);text_speed[1]	= 0.20;	 text_voice[1]	= sndRogueVoice1;
		text[2] = get_text_by_index(112);text_speed[2]	= 0.22;	 text_voice[2]	= sndRogueVoice1;
		text[3] = get_text_by_index(113);text_speed[3]	= 0.22;	 text_voice[3]	= sndRogueVoice1;
		text[4] = get_text_by_index(114);text_speed[4]	= 0.27;	 text_voice[4]	= sndRogueVoice1;

	} else
	if (get_data("said: " + get_text_by_index(47) + string(room), false) == false) {
		text[0] = get_text_by_index(47);text_speed[0]	= 0.29;	 text_voice[0]	= sndRogueVoice1;
		text[1] = get_text_by_index(48);text_speed[1]	= 0.26;	 text_voice[1]	= sndRogueVoice1;
		text[2] = get_text_by_index(49);text_speed[2]	= 0.28;	 text_voice[2]	= sndRogueVoice1;
		text[3] = get_text_by_index(50);text_speed[3]	= 0.28;	 text_voice[3]	= sndRogueVoice1;
		text[4] = get_text_by_index(51);text_speed[4]	= 0.27;	 text_voice[4]	= sndRogueVoice1;
		text[5] = get_text_by_index(52);text_speed[5]	= 0.28;	 text_voice[5]	= sndRogueVoice1;
		text[6] = get_text_by_index(53);text_speed[6]	= 0.28;	 text_voice[6]	= sndRogueVoice1;
		text[7] = "...";text_speed[7]	= 0.29;	 text_voice[7]	= sndRogueVoice1;
		text[8] = "...";text_speed[8]	= 0.29;	 text_voice[8]	= sndRogueVoice1;
	} else {
		text[0] = get_text_by_index(53);text_speed[0]	= 0.28;	 text_voice[0]	= sndRogueVoice1;
		text[1] = "...";text_speed[1]	= 0.29;	 text_voice[1]	= sndRogueVoice1;
		text[2] = "...";text_speed[2]	= 0.29;	 text_voice[2]	= sndRogueVoice1;
	}

}

	dialogue_instance = noone;
	text_index = 0;
	text_complete = false;
	
	fade_time = 150;
	auto_click_delay = 210;