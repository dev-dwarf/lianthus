/// @description
if (instance_exists(oPause)) exit;

if (!global.dark[room]) {
	if (room == rShrine and get_data("shadow_defeated", false) == false) {
	
		exit;	

	} else {
		sprite_index = sRogueDead;
	
		if (sprite_index == sRogueDead and text_complete) {
			sprite_index = sRogueDeadOut;
		}
	
		if (room != rShrine and get_data("shadow_defeated", false)) {
			exit;
		} else {
		
	
		}
	}
}

if (room == rShrine and get_data("shadow_defeated", false) == true) {
	if (!instance_exists(oLogo)) {
			instance_create_layer(oShrine.x, oShrine.y, layer, oLogo);	
		}
}

if (room == rFlats) {
	if (global.last_room != rShrine or oPlayer.throw_unlocked) and !LEVEL_EDITOR_ENABLED {
		instance_destroy();
	} else {
		image_xscale = -1;	
	}
} else {
	var facing = sign(dcos(point_direction(x,y,oPlayer.x,oPlayer.y) + oCamera.angle));
	if (global.dark[room] == false and room != rShrine) {
		if (facing == 1) {
			sprite_index = sRogue;
		} else {
			sprite_index = sRogueL;
		}
	}
	
	if (distance_to_object(oPlayer) < 16 and !text_complete) {	
		oPlayer.state = player.talk;
		
		if dialogue_instance == noone {
			dialogue_instance = instance_create_layer(oCamera.x, oCamera.y, layer, pText);
			dialogue_instance.text = text[text_index];
			dialogue_instance.text_speed = text_speed[text_index];
			dialogue_instance.voice = text_voice[text_index];
			dialogue_instance.pos = 90;
			if (sprite_index == sRogueDead) {
				dialogue_instance.pos = 60;	
			}
			//dialogue_instance.image_xscale = 1.25;
			//dialogue_instance.image_yscale = 1.5;
			dialogue_instance.destroy = auto_click_delay// + string_length(text[text_index]) * 3;
		}
			
		if (dialogue_instance != noone) {
			var advance_dialogue = false;
			if (global.gamepad_connected) {	
				advance_dialogue = g_check_p(global.gamepad_slot, gp_face3) or g_check_p(global.gamepad_slot, gp_shoulderrb);
					
			} else {
				advance_dialogue = mouse_check_button_pressed(mb_left) or check_p(vk_j);
					
			}	
				
			if (advance_dialogue or !instance_exists(dialogue_instance)) {
				if !instance_exists(dialogue_instance) or dialogue_instance.displayed_text == dialogue_instance.text  {
					instance_destroy(dialogue_instance);
					dialogue_instance = noone;
					
					if (text[text_index] == get_text_by_index(53)) {
						if (get_data("flowers",  0) >= 50) {
							global.save_data[? "flowers"] -= 50;
							if (get_data("dash", false) != true) {
								text[text_index+1] = get_text_by_index(55);	
								text[text_index+2] = get_text_by_index(56);	
							} else if (get_data("dog_defeated", false) != true) {
								text[text_index+1] = get_text_by_index(57);	
								text[text_index+2] = get_text_by_index(58);	
							} else {
								text[text_index+1] = get_text_by_index(59);	
								text[text_index+2] = get_text_by_index(60);	
							}
							play_sound(sndPlayerPickup, 10, false, 1.4, 0.3, sound_effect_volume);
						} else {
							text[text_index+1] = get_text_by_index(54);	
						}
					}
					
					text_index++;
						
					if (text_index == array_length_1d(text)) {
						dialogue_instance = -1;
						text_complete = true;
					//	global.save_data[? "said: " + text[0] + string(room)] = true;
					}
					
					text_index = clamp(text_index, 0,  array_length_1d(text) - 1);
				} else {
					dialogue_instance.text_voice = noone;
					dialogue_instance.text_speed = 1;
				}
			} else {
			}
		}
	} else {
		if (oPlayer.state == player.talk)
			oPlayer.state = player.idle;	
	}
}