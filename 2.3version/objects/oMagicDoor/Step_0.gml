/// @descript
if (get_data("shadow_defeated", false) and global.dark[room] == false and !locked) {
	sprite_index = sMagicDoorBroken;	
	
	var clone_pressed = false;
	if (global.gamepad_connected) {
		clone_pressed = g_check_p(global.gamepad_slot, gp_face4) or g_check_p(global.gamepad_slot, gp_shoulderl);
	} else {
		clone_pressed = check_p(vk_shift) or check_p(vk_space);
	}
	
	if (forced_activated) sprite_index = sMagicDoorActive;
	
	if (global.oldest_player.enter_unlocked and distance_to_object(oPlayer) < 60) {
		wobble = 0.5 * clamp(30/distance_to_object(oPlayer), 0, 3);
		var inst;
		var j = distance_to_object(oPlayer);
		var ang = point_direction(x,y,global.oldest_player.x, global.oldest_player.y)
		for (var i = -10; i <= 10; i += 10) {
			inst = instance_create_layer(x + lengthdir_x(j, ang + i), y + lengthdir_y(j, ang + i), layer, oDarkParticle);	
		}		
	}
	
	if (!forced_activated and (clone_pressed and global.oldest_player.enter_unlocked and distance_to_object(oPlayer) < 10)) {
		alarm[0] = 1;
		forced_activated = true;
		transition_triggered = true;
		
		visible = true;
		target_room = connected_room[room];
		index = 0.1
			
		if (transition_triggered) {
			audio_sound_gain(global.music_id, 0, 1000)
	
			if !global.dark[room] {
				play_sound(musDarkWorldIntro, 0, false, 1.0, 0, music_volume);
				play_sound(sndSpellUnlock, 0, false, 0.8, 0.0, music_volume);

				alarm[0] = 2 * 60;
			} else {
				play_sound(musLightWorldIntro, 0, false, 1.0, 0, music_volume);
				play_sound(sndSpellUnlock, 0, false, 1.0, 0.0, music_volume);

				alarm[0] = 3 * 60;
			}	
		}
		
		var inst;
		for (var i = 0; i < 360; i += 10) {
			for (var j = 10; j < 40; j += 10) {
				inst = instance_create_layer(x + lengthdir_x(j, i), y + lengthdir_y(j, i), layer, oDarkParticle);	
			}
		}	
	}
	
	exit;
}

if (distance_to_object(oPlayer) < 10 and locked) {
	if (get_data("keys", 0) > 0) {
		global.save_data[? "keys"]--;
		locked = false;
		instance_destroy(collision_instance);
		unlock_timer = 40;
		play_sound(sndMagicDoorOpen, 60, false, 0.8 - global.dark[room] * 0.2, 0, sound_effect_volume);	
		
		repeat(10) {
			var inst = instance_create_layer(x + irandom_range(-8, 8), y + irandom_range(-8, 8), layer, oDustParticle);
			inst.z = 4;
		}
	}
}

wobble = lerp(wobble, 0, 0.2);

if (locked) {
	collision_instance.x = x;
	collision_instance.y = y;
	
	if (global.dark[room] == false) {
		sprite_index = sMagicDoorClosed;
	} else {
		sprite_index = sMagicDoorClosedDark;
	}
} else if (unlock_timer <= 0) {
	
	if (global.dark[room] == false) {
		sprite_index = sMagicDoorActive;
		
		//if (chance(40) and abs(dcos(image_angle + oCamera.angle)) > 0.5) {
		//	var inst = instance_create_layer( x, y, layer, oDustParticle);
		//	inst.image_blend = make_color_rgb(35, 12, 69)
		
		//	inst.z = 2;
		//}
	} else {
		sprite_index = sMagicDoorActiveDark;
		
	}
	
	if !(LEVEL_EDITOR_ENABLED and oLevelEditor.editor_open) {
		if (place_meeting(x, y, oPlayer) and !transition_triggered) {
			transition_triggered = !immune;
			target_room = connected_room[room];
			
			if (transition_triggered) {
				audio_sound_gain(global.music_id, 0, 1000)
	
				if !global.dark[room] {
					play_sound(musDarkWorldIntro, 0, false, 1.0, 0, music_volume);
					alarm[0] = 2 * 60;
				} else {
					play_sound(musLightWorldIntro, 0, false, 1.0, 0, music_volume);
					alarm[0] = 3 * 60;
				}	
			}
			
		} else {
			immune = false;	
		}
	}
} else {
	unlock_timer--;	
}

visible = true;