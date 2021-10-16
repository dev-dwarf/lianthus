/// @description
if (instance_exists(oPause)) exit;

image_xscale = 1.0 + (flower_charged - 1) * 0.05;
image_yscale = image_xscale;

if (floor(image_index) == 2 and sound == noone) {
	sound = play_sound(sndBoneExplosion, 40, false, 1.0, 0.2, sound_effect_volume * 0.5);	
}

if (image_index >= image_number-1) instance_destroy();