/// @description

active = lerp(active, distance_to_object(oPlayer) < 15, 0.8);
if last_active != round(active) {
	last_active = round(active);
	play_sound(sndEyeFlap, 40, false, 1.0 + round(1 - active) * 0.5/image_xscale, 0.1, sound_effect_volume);
}

if (active > 0.5) {
	lid_frame = approach(lid_frame, 0, 0.3);	
} else {
	lid_frame = approach(lid_frame, 4, 0.15);	
}