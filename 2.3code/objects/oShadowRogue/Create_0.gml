/// @description
event_inherited();

enum rogue {
	appear,
	idle,
	shoot,
	vanish,
	dying,
	dead
}

if (global.dark[room]) {
	hp_threshold = 20;
	hp = 100;
	last_hp = hp;

	state = rogue.vanish;

	shots = 3;
	shot = false;

	aim_direction = 0;
	aim_speed = 0.2; // percent
	aim_time = 2 * room_speed;
	aim_clock = aim_time;
	
	last_angle = 0;
	if (get_data("shadow_defeated", false)) instance_destroy();
} else {
	state = rogue.dead;	
}