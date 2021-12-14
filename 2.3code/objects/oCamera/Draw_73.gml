/// @description draw cursor

//if (global.hide_gui) exit;
if (global.hide_gui) exit;

with global.oldest_player {
	if hover exit;
	if (!compass_unlocked) exit;
	if state == player.dead exit;
	
	var status = (attack_alarm <= 0) * (oPlayer.throw_unlocked);
	var sprite;
	switch status {
		case 0: sprite = sCompassMuted; break;
		case 1:	sprite = sCompass; break;
	}

	if (room == rTitle) exit;
	
	if (global.gamepad_connected) {
		#region calculate position
		var charge = (oPlayer.charge_time * 3/oPlayer.charge_max)
		var radius = 60 + charge * 8;
	
		// add a stretch factor, based off the camera scaling
		var adjusted_angle = move_direction;
		var camera_stretch = abs(lengthdir_x(1, adjusted_angle)) 
							+ abs(lengthdir_y(oCamera.image_zscale/oCamera.zscale_min, adjusted_angle));
				   
		camera_stretch /= abs(dcos(adjusted_angle)) + abs(dsin(adjusted_angle));
		
		#endregion
		draw_sprite_ext(sprite, 0, x + lengthdir_x(radius, move_direction - oCamera.angle), y + lengthdir_y(radius, move_direction - oCamera.angle), 1.0, 1.0, 0, c_white, 1.0);	
	} else {
		draw_sprite_ext(sprite, 0, round(mouse_x), round(mouse_y), 1.0, 1.0, 0, c_white, 1.0);	
	}
}


