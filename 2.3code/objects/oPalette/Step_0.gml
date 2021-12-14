/// @description
if distance_to_object(oPlayer) < 30 {
	if (distance_to_object(oPlayer) < 10) {
		x = lerp(x,oPlayer.x, 0.2);
		y = lerp(y,oPlayer.y, 0.2);
	}	
	
	if (target_dir == noone) {
		//target_dir = point_direction(oPlayer.x, oPlayer.y, x, y) + 90
		target_dir = image_angle;
	}
	
	//oCamera.angle = angle_lerp(oCamera.angle, target_dir, 0.03);
	//oCamera.x = lerp(oCamera.x, x, 0.03);
	//oCamera.y = lerp(oCamera.y, y, 0.03);

} else {
	target_dir = noone;
}

if place_meeting(x,y,oPlayer) {
	global.save_data[? "unlocked_palettes"] = clamp(get_data("unlocked_palettes", 0) + 2, 0, ds_list_size(global.palettes));
	global.save_data[? "paletteGrabbed" + string(room)] = true;
	ds_map_secure_save(global.save_data, SAVEFILE);
	global.recently_saved = 100;

	
	play_sound(sndPlayerPickup, 10, false, 1.2, 0.3, sound_effect_volume);
	
	inst = instance_create_layer(x,y,layer, pText);
			inst.destroy = 500;
			inst.pos = 60;
			inst.text = get_text_by_index(31)
			
	instance_destroy();
}