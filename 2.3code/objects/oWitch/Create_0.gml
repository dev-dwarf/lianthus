/// @description

// Inherit the parent event
event_inherited();

x = floor(x);
y = floor(y);

if (global.dark[room]) {
	sprite_index = sWitchDark;	
	if (get_data("shadow_defeated", false)) instance_destroy();
}

if (room == rShrine) {
	if (get_data("hover", true) == false and !LEVEL_EDITOR_ENABLED) {
		instance_destroy(id, false);
	}
	dialogue_instance = noone;
	start = 100;

	text_index = 0;
	text[0] = get_text_by_index(8);		text_speed[0]	= 0.18;	 text_voice[0]	= sndWitchVoice1;
	text[1] = get_text_by_index(9);		text_speed[1]	= 0.10;	 text_voice[1]	= sndWitchVoice2;
	text[2] = get_text_by_index(10);		text_speed[2]	= 0.14;	 text_voice[2]	= sndWitchVoice2;
	text[3] = get_text_by_index(11);		text_speed[3]	= 0.33;	 text_voice[3]	= sndWitchVoice1;
	text[4] = get_text_by_index(12);	text_speed[4]	= 0.30;	 text_voice[4]	= sndWitchVoice1;
	text_complete = get_data("said: " + text[0] + string(room), false);
	
	fade_time = 150;
	auto_click_delay = 210;

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
}	
if room == rWitch {
	dialogue_instance = noone;
	text_index = 0;
	
	if (get_data("shadow_defeated", false)) {
		text[0] = get_text_by_index(122);text_speed[0]	= 0.29;	 text_voice[0]	= sndWitchVoice1;
		text[1] = get_text_by_index(123);text_speed[1]	= 0.29;	 text_voice[1]	= sndWitchVoice1;
	} else if (get_data("dog_defeated", false)) {
		text[0] = get_text_by_index(26);text_speed[0]	= 0.29;	 text_voice[0]	= sndWitchVoice1;
		text[1] = get_text_by_index(27);text_speed[1]	= 0.29;	 text_voice[1]	= sndWitchVoice1;
		text[2] = get_text_by_index(28);text_speed[2]	= 0.25;	 text_voice[2]	= sndWitchVoice1;
	} else if (get_data("charge", false)) {
		text[0] = get_text_by_index(22);text_speed[0]	= 0.30;	 text_voice[0]	= sndWitchVoice1;
		text[1] = get_text_by_index(23);text_speed[1]	= 0.25;	 text_voice[1]	= sndWitchVoice1;
		text[2] = get_text_by_index(24);text_speed[2]	= 0.23;	 text_voice[2]	= sndWitchVoice1;
		text[3] = get_text_by_index(25);text_speed[3]	= 0.25;	 text_voice[3]	= sndWitchVoice1;
	} else if (get_data("dash", false)) {
		text[0] = get_text_by_index(20);text_speed[0]	= 0.26;	 text_voice[0]	= sndWitchVoice1;
		text[1] = get_text_by_index(21);text_speed[1]	= 0.26;	 text_voice[1]	= sndWitchVoice1;
	} else if (get_data("throw", false)) {
		text[0] = get_text_by_index(18);text_speed[0]	= 0.25;	 text_voice[0]	= sndWitchVoice1;
		text[1] = get_text_by_index(19);text_speed[1]	= 0.20;	 text_voice[1]	= sndWitchVoice1;
	} else {
		text[0] = get_text_by_index(13);text_speed[0]	= 0.30;	 text_voice[0]	= sndWitchVoice1;
		text[1] = get_text_by_index(14);text_speed[1]	= 0.25;	 text_voice[1]	= sndWitchVoice1;
		text[2] = get_text_by_index(15);text_speed[2]	= 0.18;	 text_voice[2]	= sndWitchVoice1;
		text[3] = get_text_by_index(16);text_speed[3]	= 0.18;	 text_voice[3]	= sndWitchVoice1;
		text[4] = get_text_by_index(17);text_speed[4]	= 0.18;	 text_voice[4]	= sndWitchVoice1;
	}
	text_complete = get_data("said: " + text[0] + string(room), false);
	
	fade_time = 150;
	auto_click_delay = 210;
}
if room == rWitchDark {
	dialogue_instance = noone;
	text_index = 0;
	
	text[0] = get_text_by_index(29);text_speed[0]	= 0.18;	 text_voice[0]	= sndWitchDarkVoice;
	text[1] = get_text_by_index(30);text_speed[1]	= 0.16;	 text_voice[1]	= sndWitchDarkVoice;
	text_complete = get_data("said: " + text[0] + string(room), false);
	
	fade_time = 150;
	auto_click_delay = 210;
}

