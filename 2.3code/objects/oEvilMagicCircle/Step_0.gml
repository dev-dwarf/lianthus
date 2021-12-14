/// @description
if (place_meeting(x,y,oPlayer)) {
	clone_z = lerp(clone_z, max_z * !triggered, 0.06);
	
	if abs(clone_z - max_z) < 0.2 and !triggered {	
		triggered = true;
		global.save_data[? "finale"] = true;
		global.save_data[? "doorLocked" + string(room)] = false;
		instance_change(oMagicDoor, true);
		x = global.oldest_player.x;
		y = global.oldest_player.y;
	
		ds_map_secure_save(global.save_data, SAVEFILE);
		global.recently_saved = 100;
	} else {
		if (!triggered) {
			//oCamera.angle += 2;	
			oCamera.screenshake = 0.25;
			var inst = instance_nearest(x,y,oPointOfInterest);
			inst.image_angle += 4.5;	
		}
	}
} else {
	clone_z = lerp(clone_z, 0, 0.2);
}