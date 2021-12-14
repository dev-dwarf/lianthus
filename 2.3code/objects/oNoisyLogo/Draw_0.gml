/// @description
if (wait-- > 0) exit;

if (wait == -1) {
	wait--;
	play_sound(sndNoisyBugSwish, 0, false, 1.0, 0.0, sound_effect_volume);	
}


x = lerp(x, room_width/2, 0.5);

if (round(x) == room_width/2) {
	if (image_xscale == 0.25) {
	}
	
	image_xscale = lerp(image_xscale, 1.0, 0.35);
	image_yscale = lerp(image_yscale, 1.0, 0.35);	
}

draw_sprite_ext(sprite_index, 0, x, 120, image_xscale, image_yscale, image_angle, image_blend, image_alpha);