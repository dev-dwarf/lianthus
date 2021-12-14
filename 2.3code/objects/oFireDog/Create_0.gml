/// @description

// Inherit the parent event
event_inherited();
	
	chase_direction = 0;
	chase_speed_max = 1.21;
	chase_accel = 0.025;
	chase_speed = 0;
	chase_attack_count = 3// + 1 * (3-hp)
	
	attack_speed = 2.9;
	attack_decel = 0.11;
	attack_accel = 0.55;
	attack_range = 55;
	attack_timer = 60;
	attack_hit_this_time = false;
	attack_accelerated = false;
	attack_timer_max = 100;
	
	state = dog.chase;
	footstep_played = false;
