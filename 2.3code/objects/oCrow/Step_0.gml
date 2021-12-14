/// @description

if (flying) {
	sprite_index = sCrowFlight;
	depth = -10000;

	z += 1;

	move_speed = approach(move_speed, 7, 0.1);
	x += lengthdir_x(move_speed, direction);
	y += lengthdir_y(move_speed, direction);
} else {
	if (point_distance(x,y,oPlayer.x,oPlayer.y) < 90) and !(LEVEL_EDITOR_ENABLED and !global.hide_gui) {
		flying = true;
	}
}

if (last_flying != flying) {
	if !audio_is_playing(sndBirdFlyAway) or chance(25)
		play_sound(sndBirdFlyAway, 40, false, 1.0, 0.3, sound_effect_volume);	
		
	direction = 45 + irandom_range(-5, 5) - oCamera.angle;
	
	if (chance(99))
		last_flying = flying;
		
	alarm[0] = 400;
}