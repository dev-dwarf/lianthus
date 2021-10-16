/// @description
event_inherited();

enum shadow {
	intro	 = -1,
	summon	 = 0,
	idle	 = 1,
	attack	 = 2,
	recovery = 3,
	vanish	 = 4,
	vanished = 5,
	defeated = 6,
}

if (get_data("shadow_defeated", false)) instance_destroy();

hp = 60;
max_hp = hp;
hp_threshold = hp/4;

spawn_rogue_threshold = 30;

last_hp = hp;

if (get_data("has_fought_shadow", false)) {
	state = shadow.summon;
	instance_create_layer(0, 0, layer, oAmbiencePlayer);
} else {
	state = shadow.intro;
	hp = 1;


}
	dialogue_instance = noone;
	text_index = 0;
	text_complete = false;
	
	auto_click_delay = 210;
	
	text[0] = get_text_by_index(104);text_speed[0]	= 0.25;	 text_voice[0]	= sndShadowVoice;
	text[1] = get_text_by_index(105);text_speed[1]	= 0.25;	 text_voice[1]	= sndShadowVoice;
	text[2] = get_text_by_index(106);text_speed[2]	= 0.26;	 text_voice[2]	= sndShadowVoice;
	text[3] = get_text_by_index(107);text_speed[3]	= 0.24;	 text_voice[3]	= sndShadowVoice;

shots = 6;

fade_time = 120;

aim_direction = 0;
aim_speed = 0.2; // percent
aim_time = 120 * 6/shots;
aim_clock = aim_time;

shot = false;
scale = 1.0;

recovery_time = 5.0 * room_speed;
recovery_clock = recovery_time;

fire_spawn_angle = 45;

//maximum_possesions = 4;

vanished_time = 7 * room_speed;
vanished_clock = vanished_time;

set_camera = false;