/// @description
if (instance_exists(oPause)) exit;


if room == rField or room == rFieldDark {
	var facing = sign(dcos(point_direction(x,y,oPlayer.x,oPlayer.y) + oCamera.angle));
	if (facing == 1) {
		if (!global.dark[room]) {
			sprite_index = sBoy;
		} else {
			sprite_index = sBoyDark;
		}
	} else {
		if (!global.dark[room]) {
			sprite_index = sBoyL;
		} else {
			sprite_index = sBoyDarkL;
		}
	}
	
	if (distance_to_object(oPlayer) < 16 and !text_complete) {	
		
		oPlayer.state = player.talk;
		
		if dialogue_instance == noone {
			dialogue_instance = instance_create_layer(oCamera.x, oCamera.y, layer, pText);
			dialogue_instance.text = text[text_index];
			dialogue_instance.text_speed = text_speed[text_index];
			dialogue_instance.voice = text_voice[text_index];
			
			// this option sounds bad haha
			//if (global.dark[room]) {
			//	dialogue_instance.alt_voice = text_voice[text_index];
			//} else {
			//	dialogue_instance.alt_voice = sndBoyVoice2;
			//}
			
			dialogue_instance.pos = 90;
			//dialogue_instance.image_xscale = 1.25;
			//dialogue_instance.image_yscale = 1.5;
			dialogue_instance.destroy = auto_click_delay + string_length(text[text_index]) * 3;
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
					text_index++;
						
					if (text_index == array_length_1d(text)) {
						dialogue_instance = -1;
						text_complete = true;
						global.save_data[? "said: " + text[0] + string(room)] = true;
					}
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