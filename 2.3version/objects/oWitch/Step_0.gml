/// @description
if (instance_exists(oPause)) exit;


if (room == rShrine and get_data("hover", true) ) {
	if (distance_to_object(oShrine) > 0) and (start <= 0) {
		//x += lengthdir_x(0.7, point_direction(x,y,oShrine.x + 40,oShrine.y));	
		//y += lengthdir_y(0.7, point_direction(x,y,oShrine.x + 40,oShrine.y));	
		
		
		x = lerp(x, oShrine.x + 40, 0.012);
		y = lerp(y, oShrine.y, 0.012);
		image_xscale = -1;
	} else {
		start--;	
		
		if (start <= 0 and !text_complete) {
		
			if !(distance_to_object(oShrine) > 50) {
				oCamera.angle = angle_lerp(oCamera.angle, -30, 0.008);
			}
			
		
			if dialogue_instance == noone and distance_to_object(oShrine) <= 2 {
				dialogue_instance = instance_create_layer(oShrine.x, oShrine.y + 40, layer, pText);
				dialogue_instance.text = text[text_index];
				dialogue_instance.text_speed = text_speed[text_index];
				dialogue_instance.voice = text_voice[text_index];
				//dialogue_instance.image_xscale = 1.25;
				//dialogue_instance.image_yscale = 1.5;
				dialogue_instance.destroy = auto_click_delay + string_length(text[text_index]) * 2;
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
						}
					} else {
						dialogue_instance.text_voice = noone;
					dialogue_instance.text_speed = 1;
					}
				}
			}
		}
	}
	
	if fade_time > 0 {
		if (text_complete) {
			if (!audio_is_playing(sndDarknessAppears)) {
				play_sound(sndDarknessAppears, 30, false, 1.0, 0.0, sound_effect_volume);
				audio_sound_gain(sndDarknessRumble, 0, 1000);
				audio_sound_gain(global.music_id, 0, 1000);
			}
			
			oCamera.screenshake = 0.25;
			repeat(choose(3, 4, 5)) {
				part_particles_create(magic_circles, oShrine.x + irandom_range(20, 150) * choose(-1, 1), oShrine.y + irandom_range(0, 60) * choose(-1, 1), magic_circle, 1);
				part_particles_create(magic_circles, oShrine.x + irandom_range(20, 150) * choose(-1, 1), oShrine.y + irandom_range(0, 60) * choose(-1, 1), dark_particle, 1);
		
			}
			fade_time = approach(fade_time, 0, 1);
			oPlayer.hover_sprite = sPlayerHoverAwake;
			visible = true;
		} else if (text_index >= 3) {
			sprite_index = sWitch;
			oCamera.screenshake = 0.15;
				part_particles_create(magic_circles, oShrine.x + irandom_range(20, 150) * choose(-1, 1), oShrine.y + irandom_range(0, 60) * choose(-1, 1), dark_particle, choose(0,1));
			part_particles_create(magic_circles, oShrine.x + irandom_range(20, 150) * choose(-1, 1), oShrine.y + irandom_range(0, 60) * choose(-1, 1), magic_circle, choose(1,0, 0, 0));
		} else if (text_index >= 2) {
			if (!audio_is_playing(sndDarknessRumble)) {
				play_sound(sndDarknessRumble, 30, true, 1.0, 0.0, sound_effect_volume);
			}
			
			
			oCamera.screenshake = 0.05;
			part_particles_create(magic_circles, oShrine.x + irandom_range(20, 150) * choose(-1, 1), oShrine.y + irandom_range(0, 60) * choose(-1, 1), magic_circle, choose(1,0, 0, 0));
		} else if text_index >= 1 {
			sprite_index = sWitchMagic;

		}
	} else {
		//play_sound(sndWitchScream, 50, false, 1.0, 0, sound_effect_volume);
		global.save_data[? "hover"] = false;
		load_room("shrine.room");
		oPlayer.hover = false;
		instance_create_layer(x,y,layer,oWitchFlyAway);
		instance_create_layer(x,y,layer,oWitchTransition) ;
		oWitchTransition.radius = radius;
	}
}

if room == rWitch or room == rWitchDark {
	var facing = sign(dcos(point_direction(x,y,oPlayer.x,oPlayer.y) + oCamera.angle));
	if (facing == 1) {
		if (!global.dark[room]) {
			sprite_index = sWitch;
		} else {
			sprite_index = sWitchDark;
		}
	} else {
		if (!global.dark[room]) {
			sprite_index = sWitchL;
		} else {
			sprite_index = sWitchDarkL;
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
			}
		}
	} else {
		if (oPlayer.state == player.talk)
			oPlayer.state = player.idle;	
	}
}
