/// @desc move()
/// @arg speed
/// @arg direction
function move() {
 
	var spd = argument[0];
	var dir = argument[1];

	var angle_correction = true;
	if (argument_count > 2) {
		angle_correction = argument[2];	
	}

	// add a stretch factor, based off the camera scaling
	var adjusted_angle = dir + oCamera.angle;
	var camera_stretch = abs(lengthdir_x(1, adjusted_angle)) 
					   + abs(lengthdir_y(oCamera.image_zscale/oCamera.zscale_min, adjusted_angle));
				   
	camera_stretch /= abs(dcos(adjusted_angle)) + abs(dsin(adjusted_angle));

	var xtarg = x+lengthdir_x(spd*camera_stretch,dir);
	var ytarg = y+lengthdir_y(spd*camera_stretch,dir);

	if !place_meeting(xtarg, ytarg, pSolid) and !place_meeting(xtarg, ytarg, pHitbox) and spd < 6  {
	    x = xtarg;
	    y = ytarg;
	} else {
		if (angle_correction) {
			spd *= 0.75;
	
			for (var i = 0; i < 80; i += 10) {
				xtarg = x+lengthdir_x(spd,dir + i);
				ytarg = y+lengthdir_y(spd,dir + i);
		
				if !place_meeting(xtarg, ytarg, pSolid) and !place_meeting(xtarg, ytarg, pHitbox) {
					x = xtarg;
					y = ytarg;
					return false;
				}
		
				xtarg = x+lengthdir_x(spd,dir - i);
				ytarg = y+lengthdir_y(spd,dir - i);
		
				if !place_meeting(xtarg, ytarg, pSolid) and !place_meeting(xtarg, ytarg, pHitbox) {
					x = xtarg;
					y = ytarg;
					return false;
				}
			}
	
			return true;
		} else {
			var xstep = lengthdir_x(1,dir);
			var ystep = lengthdir_y(1,dir);

		    for (var i = 0; i < floor(spd); i++) {
				if (!place_meeting(x+xstep, y, pSolid) and !place_meeting(x+xstep, y, pHitbox)) {
					x += xstep;
				} else {
					return true;
					break;
				}
				if (!place_meeting(x, y+ystep, pSolid) and !place_meeting(x, y+ystep, pHitbox)) {
					y += ystep;
				} else {
					return true;
					break;	
				}
			}
		}
	}
	
	return false;



}
