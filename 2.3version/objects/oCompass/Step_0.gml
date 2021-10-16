/// @description
if (instance_exists(oPause)) exit;

if distance_to_object(oPlayer) < 25 {
	x = lerp(x,oPlayer.x, 0.1);
	y = lerp(y,oPlayer.y, 0.1);
	
	image_xscale = 1 + distance_to_object(oPlayer)/25;
	image_yscale = 1 + distance_to_object(oPlayer)/25;
}

if (place_meeting(x,y,oPlayer) and !created_text) {
	play_sound(sndPlayerPickup, 10, false, 1.2, 0.3, sound_effect_volume);

	oPlayer.compass_unlocked = true;
	oPlayer.state = player.talk;
	global.save_data[? "compass_unlocked"] = true;
	
	created_text = true;

	var dialogue_instance = instance_create_layer(oCamera.x, oCamera.y, layer, pText);
	dialogue_instance.text = get_text_by_index(118) + " " + get_text_by_index(119);
	dialogue_instance.pos  = 50;
	dialogue_instance.destroy = 200;
	
}

if (created_text and !instance_exists(pText)) {
	oPlayer.state = player.idle;
	
	instance_destroy();	

}


z = 2 + 2 * dsin(oPlayer.image_index * 90);