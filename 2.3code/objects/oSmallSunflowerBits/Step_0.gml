/// @description
if (instance_exists(oPause)) exit;


if distance_to_object(oPlayer) < 20 {
	x = lerp(x,oPlayer.x, 0.2);
	y = lerp(y,oPlayer.y, 0.2);
}

if place_meeting(x,y,oPlayer) {
	global.save_data[? "flowers"] += 1;
	play_sound(sndPlayerPickup, 10, false, 1.2, 0.3, sound_effect_volume);
	instance_destroy();
}

z = 2 + 2 * dsin(oPlayer.image_index * 90);