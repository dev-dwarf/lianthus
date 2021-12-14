/// @description
if (place_meeting(x,y,oPlayer)) {
	image_angle += 1;	
	
	clone_z = lerp(clone_z, max_z * !triggered, 0.06);
	
	if abs(clone_z - max_z) < 0.2 and !triggered {	
		switch room {
			case rWitchDark:
	
			global.save_data[? "throw"] = true;	
			global.save_data[? "active_columns"] += 2;	
			oPlayer.throw_unlocked = true;	
			triggered = true;
		
			var inst;
			for (var i = 0; i < 360; i += 45) {
				inst = instance_create_layer(x + lengthdir_x(50, i), y + lengthdir_y(50, i), layer, oRock);	
				inst.sprite_index = inst.cracked_sprite;

			}
			inst = instance_create_layer(x,y,layer, pText);
			inst.destroy = 500;

			if (global.gamepad_connected) {
				if (global.gamepad_is_xbox) {
					inst.text = get_text_by_index(2);
				} else {
					inst.text = get_text_by_index(3);
				}
			} else {
				inst.text = get_text_by_index(4)
			}
			break;
			case rFieldDark:
			global.save_data[? "dash"] = true;
			global.save_data[? "active_columns"] += 4;	
			oPlayer.dash_unlocked = true;	
			triggered = true;
			
			var inst;
			
			//spawn ring of fire
			for (var i = 0; i < 360; i += 20) {
				inst = instance_create_layer(x + lengthdir_x(35, i), y + lengthdir_y(35, i), layer, oMagicFire);	
				inst.image_angle = i + 90;
				inst.image_xscale = 1.0;

			}
			
		//	inst = instance_nearest(x,y,oOrb);
		//	inst.active = false;			
			
			inst = instance_create_layer(x,y,layer, pText);
			inst.destroy = 500;

			if (global.gamepad_connected) {
				if (global.gamepad_is_xbox) {
					inst.text = get_text_by_index(5);
				} else {
					inst.text = get_text_by_index(6);
				}
			} else {
				inst.text = get_text_by_index(7);
			}
			break;
			case rEast:
			global.save_data[? "charge"] = true;
			global.save_data[? "active_columns"] += 8;	
			oPlayer.charge_unlocked = true;	
			triggered = true;
			
			var inst;
			
			//spawn ring of skulls
			for (var i = 0; i < 360; i += 45) {
				inst = instance_create_layer(x + lengthdir_x(30, i), y + lengthdir_y(30, i), layer, oSunflower);	
				inst.image_angle = i;

			}
			inst = instance_create_layer(x,y,layer, pText);
			inst.destroy = 500;

			if (global.gamepad_connected) {
				if (global.gamepad_is_xbox) {
					inst.text = get_text_by_index(44);
				} else {
					inst.text = get_text_by_index(45);
				}
			} else {
				inst.text = get_text_by_index(46);
			}
			break;
			case rNorth:
			global.save_data[? "clone"] = true;
			global.save_data[? "active_columns"] += 1;	
			oPlayer.clone_unlocked = true;	
			triggered = true;
			
			var inst;
			
			//spawn ring of skulls
			for (var i = 0; i < 360; i += 60) {
				inst = instance_create_layer(x + lengthdir_x(18, i), y + lengthdir_y(18, i), layer, oSkull);	
				inst.image_angle = i;
				inst.image_xscale = 1.0 + random_range(-0.1, -0.1);
				inst.image_yscale = 1.0 + random_range(-0.1, -0.1);

			}
			inst = instance_create_layer(x,y,layer, pText);
			inst.destroy = 500;

			if (global.gamepad_connected) {
				if (global.gamepad_is_xbox) {
					inst.text = get_text_by_index(71);
				} else {
					inst.text = get_text_by_index(72);
				}
			} else {
				inst.text = get_text_by_index(73);
			}
			break;
			case rField:
			global.save_data[? "enter"] = true;
			oPlayer.enter_unlocked = true;	
			triggered = true;
			
			var inst;
			
			//spawn ring of skulls
			for (var i = 0; i < 360; i += 2) {
				inst = instance_create_layer(x + lengthdir_x(18, i), y + lengthdir_y(18, i), layer, oDarkParticle);	
				inst.image_angle = i;
				inst.image_xscale = 1.0 + random_range(-0.1, -0.1);
				inst.image_yscale = 1.0 + random_range(-0.1, -0.1);

			}
			inst = instance_create_layer(x,y,layer, pText);
			inst.pos = 50;
			inst.destroy = 500;

			if (global.gamepad_connected) {
				if (global.gamepad_is_xbox) {
					inst.text = get_text_by_index(124);
				} else {
					inst.text = get_text_by_index(125);
				}
			} else {
				inst.text = get_text_by_index(126);
			}
			break;
		}
		
		if (global.dark[room]) {
			play_sound(sndSpellUnlock, 0, false, 0.8, 0.0, music_volume);
		} else {
			play_sound(sndSpellUnlock, 0, false, 1.0, 0.0, music_volume);			
		}
		
		ds_map_secure_save(global.save_data, SAVEFILE);
		global.recently_saved = 100;

	} else {
		if (!triggered) {
			//oCamera.angle += 2;	
			oCamera.screenshake = 0.25;
		}
	}
} else {
	clone_z = lerp(clone_z, 0, 0.2);
}