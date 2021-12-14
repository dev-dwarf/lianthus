/// @description

image_angle += 2;
image_angle = image_angle mod 360;

if (active) {
	if (active_alarm == 0) {
		instance_deactivate_object(id);	
		with object_index {
			if active {
				instance_deactivate_object(id);	
			}
		}
	
		var inst = instance_nearest(x,y,object_index);
		instance_activate_object(object_index);
	
		if (inst != noone) {
			inst.active = true;	
		}

		if (collision_instance != noone) {
			instance_destroy(collision_instance);
			collision_instance  = noone;
		
		}
		active_alarm--;
	} else if active_alarm > 0 {
		active_alarm--;	
	}
	
	z = lerp(z, -1000, 0.1);
	
	sprite_index = sBridgeActive;
} else {
	collision_instance.x = x;
	collision_instance.y = y;
}