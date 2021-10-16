/// @description
if (!set_camera) {
	set_camera = true;

	camera_object = instance_nearest(x,y,oPointOfInterest);
	camera_object.x = x;

	instance_deactivate_object(oPointOfInterest);
	instance_activate_object(camera_object);	
}

if (instance_exists(oPause) or global.oldest_player.state == player.dead) exit;

if (!instance_exists(oPlayer) or !instance_exists(global.oldest_player)) {
	exit;	
}


mask_index = sShadow;

var target_inst = instance_nearest(x,y,oPlayer);
while target_inst.state == player.dead {
	instance_deactivate_object(target_inst);
	target_inst = instance_nearest(x,y,oPlayer);
}

switch state {
	case shadow.intro		: #region
	if (distance_to_object(oPlayer) < 70 and !text_complete) {	
		hp = lerp(hp, max_hp, 0.5);
		
		oPlayer.state = player.talk;
		
		if dialogue_instance == noone {
			dialogue_instance = instance_create_layer(oCamera.x, oCamera.y, layer, pText);
			dialogue_instance.text = text[text_index];
			dialogue_instance.text_speed = text_speed[text_index];
			dialogue_instance.voice = text_voice[text_index];
			dialogue_instance.pos = 20;
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
		if (oPlayer.state == player.talk) {
			oPlayer.state = player.idle;	
			state = shadow.attack;	
			instance_create_layer(0, 0, layer, oAmbiencePlayer);
		}
	}
	
	global.save_data[? "has_fought_shadow"] = true;
	
	break;#endregion
	case shadow.summon		: #region 
	sprite_index = sShadowAppear;

	instance_activate_object(oPlayer);
	
	aim_direction = lerp(aim_direction, point_direction(x, y, target_inst.x, target_inst.y), aim_speed);
	
	if (image_index >= image_number - 1.5) {
		state = shadow.idle;
		image_index = 0;
	}	

	
	break; #endregion
	case shadow.idle		: #region 
	sprite_index = sShadow;
	
	instance_activate_object(oPlayer);
	aim_direction = lerp(aim_direction, point_direction(x, y, target_inst.x, target_inst.y), aim_speed);
	
	aim_clock--;
	
	if (aim_clock <= 0) {
		image_index = 0;
		state = shadow.attack;	
		aim_clock = aim_time;
	}
	
	break; #endregion
	case shadow.attack		: #region 
	sprite_index = sShadowAttack;
	
	if (ceil(image_index) == 3) {
		if (!shot) {
			shots--;
			shot = true;
			
			play_sound(sndShadowShoot, 0, false, 1.0, 0.1, sound_effect_volume);
			
			var inst = instance_create_layer(x,y,layer,oFireSkull);
			inst.direction = aim_direction;
					
			if (hp <= spawn_rogue_threshold and shots == 0) {
				scale = 1.25;
				
				var inst = instance_create_layer(x,y,layer,oFireSkull);
				inst.direction = aim_direction - 20;
				var inst = instance_create_layer(x,y,layer,oFireSkull);
				inst.direction = aim_direction + 20;
			} else if (shots == 4) {
				inst.direction += 180;
				inst.speed = 3.5;	
			}		
			
			
			//log("Shot");
		} 
		
		if (shots == 0) {
			state = shadow.recovery;			
			recovery_clock = recovery_time;
		}
	} else {
		aim_direction = lerp(aim_direction, point_direction(x, y, target_inst.x, target_inst.y), aim_speed);
		
		shot = false;	
	}
	
	break; #endregion
	case shadow.recovery	: #region 
	if (instance_exists(oMagicFire)) {
		instance_destroy(oMagicFire);
	}
	sprite_index = sShadowRecovery;
	aim_direction = lerp(aim_direction, point_direction(x, y, target_inst.x, target_inst.y), aim_speed);
	
	recovery_clock--;
	
	var inst = instance_place(x,y,oBone)
	if (inst) {
		instance_destroy(inst);
	}
	
	with oBonesplosion {
		if (place_meeting(x,y,oShadow) and !damaged) {
			oShadow.hp -= flower_charged + 1;
			oShadow.scale = 0.8;
			damaged = true;
			play_sound(sndShadowHurt, 0, false, 1.0, 0.6, sound_effect_volume * 0.7);
			play_sound(sndShadowVoice, 0, false, 1.0, 0.2, sound_effect_volume);
			play_sound(sndRockHit, 0, false, 1.0, 0.2, sound_effect_volume);

			
		}
	}
	
	if (recovery_clock == 0 or hp <= last_hp - hp_threshold) {
		image_index = 0;
		state = shadow.vanish;	
		
		play_sound(sndShadowPossesion, 0, false, 1.0, 0.1, sound_effect_volume);
		
		if (hp <= spawn_rogue_threshold and last_hp > spawn_rogue_threshold) {
			instance_create_layer(x,y,layer,oShadowRogue);
		}
		last_hp = hp;
	}
	
	break; #endregion
	case shadow.vanish		: #region 
	aim_direction = lerp(aim_direction, point_direction(x, y, target_inst.x, target_inst.y), aim_speed);
	sprite_index = sShadowVanish;
	
	if (image_index >= image_number - 1.5) {
		state = shadow.vanished;
		shots = round(6 + 3 * (1 - hp/max_hp));
		
		image_index = 0;
		
		with oPlayer {
			possesed = true;
		}
		
		play_sound(sndShadowLeave, 100, false, 1.0, 0.2, sound_effect_volume);

		//var count = 0;
		//with oPlayer {
		//	if count < other.maximum_possesions-1 {
		//		possesed = true;
		//		count++;
		//	}
		//}
	}	
	break; #endregion
	case shadow.vanished	: #region
	vanished_clock--;
	
	if (vanished_clock == 0) {
		image_index = 0;
		state = shadow.summon;	
		vanished_clock = vanished_time;
		fire_spawn_angle = choose(0, 45);
		
		for (var i = 0; i < 360; i += 90) {
			inst = instance_create_layer(x + lengthdir_x(75, i + fire_spawn_angle), y + lengthdir_y(75, i + fire_spawn_angle), layer, oFireSummoner);	
			inst.image_angle = i + 90;
			inst.image_xscale = 0.45;
			inst.image_yscale = 0.45;
			inst.time = -1;
			inst.alarm[0] = 40;

		}	

	}
	
	break; #endregion
	case shadow.defeated: #region
	camera_object.x = xstart;
	camera_object.y = ystart;
	camera_object.image_angle = angle_lerp(camera_object.image_angle, 0, 0.15);
	oCamera.x = lerp(oCamera.x, x, 0.15);
	oCamera.y = lerp(oCamera.y, y, 0.15);
	oCamera.screenshake = 0.3;

	instance_activate_object(oPointOfInterest);
	
	fade_time = approach(fade_time, 0, 1);
	
	if (fade_time == 0) {
		if (!text_complete) {	
		oPlayer.state = player.talk;
		
		if dialogue_instance == noone {
			dialogue_instance = instance_create_layer(oCamera.x, oCamera.y, layer, pText);
			dialogue_instance.text = text[text_index];
			dialogue_instance.text_speed = text_speed[text_index];
			dialogue_instance.voice = text_voice[text_index];
			dialogue_instance.destroy = auto_click_delay + string_length(text[text_index]) * 3;
		}
			
		if (dialogue_instance != noone) {
			if (!instance_exists(dialogue_instance)) {
				if !instance_exists(dialogue_instance) or dialogue_instance.displayed_text == dialogue_instance.text  {
					instance_destroy(dialogue_instance);
					dialogue_instance = noone;
					

					text_index++;
						
					if (text_index == array_length_1d(text)) {
						dialogue_instance = -1;
						text_complete = true;
						global.save_data[? "said: " + text[0] + string(room)] = true;
						
						global.save_data[? "shadow_defeated"] = true;
						ds_map_secure_save(global.save_data, SAVEFILE);
						recently_saved = 50;

						global.last_room = rShrineDark;
						room_goto(rShrine);
					}
				} else {
					dialogue_instance.text_voice = noone;
					dialogue_instance.text_speed = 1;
				}
			} else {
				if (text_index == 1) {
					dialogue_instance.text += string_char_at(dialogue_instance.text, string_length(dialogue_instance.text)-1);	
				}
			}
		}
	} else {
		if (oPlayer.state == player.talk) {
			oPlayer.state = player.idle;	
			state = shadow.attack;	
		}
	}
	}
	
	exit;
	break; #endregion
}

if (hp <= 0 and state != shadow.defeated) {
	text_complete = false;
	text_index = 0;
	dialogue_instance = noone;
	
	text = array_create(2, 0);
	text[0] = get_text_by_index(108);text_speed[0]	= 0.25;	 text_voice[0]	= sndShadowVoice;
	text[1] = get_text_by_index(109);text_speed[1]	= 0.25;	 text_voice[1]	= sndShadowVoice;
	
	state = shadow.defeated;
	if (instance_exists(oShadowRogue))
		oShadowRogue.state = rogue.dying;
	global.save_data[? "shadow_defeated"] = true;
	
	instance_deactivate_object(global.oldest_player);
	with oPlayer { instance_change(oBones, true); }
	instance_activate_object(global.oldest_player);
	
} else {
	scale = lerp(scale, 1.0, 0.35);
	
	
	var player_x = 0, player_y = 0, players = 0;
	
	if (global.oldest_player.state == player.dead) {
		player_x = global.oldest_player.x;
		player_y = global.oldest_player.y;

	} else {
		with oPlayer {
			if state != player.dead {
				player_x += x;
				player_y += y;
				players++;
			}
		}
	
		player_x /= players;
		player_y /= player_y;
	}
	
	
	if (state == shadow.recovery) {
		camera_object.x = (x * 0.9 + player_x * 1.1);	
		camera_object.y = (y * 0.9 + player_y * 1.1);
		
		if (instance_exists(oShadowRogue)) {
			camera_object.x += 0.5 * oShadowRogue.x;
			camera_object.y += 0.5 * oShadowRogue.x;	
			camera_object.x /= 2.5;
			camera_object.y /= 2.5;

		} else {
			camera_object.x /= 2.0;
			camera_object.y /= 2.0;
		}
	} else {
		camera_object.x = (x * 0.75 + player_x * 1.25);	
		camera_object.y = (y * 0.75 + player_y * 1.25);
		
		if (instance_exists(oShadowRogue)) {
			camera_object.x += 0.5 * oShadowRogue.x;
			camera_object.y += 0.5 * oShadowRogue.x;	
			camera_object.x /= 2.5;
			camera_object.y /= 2.5;

		} else {
			camera_object.x /= 2.0;
			camera_object.y /= 2.0;
		}	
	}
	
	camera_object.image_angle = lerp(camera_object.image_angle, (point_direction(x,y,global.oldest_player.x, global.oldest_player.y) - 180) * 0.06, 0.08);

	if (dcos(aim_direction + oCamera.angle) != 0) {
		if (distance_to_object(global.oldest_player) > 10) {
			image_xscale = sign(dcos(aim_direction + oCamera.angle));
		}
	}
}
