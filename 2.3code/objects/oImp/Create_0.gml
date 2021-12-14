/// @description

// Inherit the parent event
event_inherited();

enum imp {
	spawn,
	chase,
	swing
	
}

state = imp.spawn;

chase_direction = 0;
chase_speed = 0;
chase_speed_max = oPlayer.move_speed_max + 0.125;
chase_speed_accel = 0.075;
chase_speed_decel = 0.15;

target_direction = 0;
target_timer = 0;


made_footstep = false;

play_sound(sndImpSpawn, 0, false, 1.5, 0.1, sound_effect_volume);
