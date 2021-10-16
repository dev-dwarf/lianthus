/// @description
if (instance_exists(oPause)) exit;

if (finished) exit;

if (!dog_spawned) {
	if (place_meeting(x,y,oPlayer)) {
		angle_speed = approach(angle_speed, 2.5, 0.04);
		active = true;	

		if (angle_speed == 2.5) {
			particle_timer--;
			
			// create magic particles
			oCamera.screenshake = approach(oCamera.screenshake, 0.35, 0.2/oCamera.screenshake); var r, a;
			repeat(choose(3, 4, 5)) {
				r = irandom_range(50, 140); a = irandom_range(0, 359);
				part_particles_create(magic_circles, x + r*dcos(a), y + r*dsin(a), magic_circle, choose(0, 1));
				repeat(2) {
					r = irandom_range(50, 110); a = irandom_range(0, 359);
					part_particles_create(magic_circles, x + r*dcos(a), y + r*dsin(a), dark_particle, 1);
				}
			}
		
			if (particle_timer == 0) {
				//spawn dog 
				global.save_data[? "has_fought_dog"] = true;
				ds_map_secure_save(global.save_data, SAVEFILE);
				global.recently_saved = 100;

				var doge = instance_create_layer(x,y,layer,oDog);
				doge.sprite_index = sDogDarkVanish;
				
				var door = instance_create_layer(436, 552, layer, oDogDoor);
				door.image_xscale = 4.0;
								
				dog_spawned = true;				
			}
		}	
	} else {
		angle_speed = approach(angle_speed, 0, 0.1);
		active = false;	
	}

	image_angle += angle_speed;
} else {
	image_xscale = lerp(image_xscale, 0, 0.05);
	image_yscale = image_xscale;
}