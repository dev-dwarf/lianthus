/// @description
if (LEVEL_EDITOR_ENABLED and oLevelEditor.editor_open) exit;

if (instance_exists(oPause)) exit;

if (!instance_exists(global.oldest_player)) {
	global.oldest_player = id; // this code will correctly set the oldest player,
								// since instances run events in creation order
}

lerped_hp = lerp(lerped_hp, hp, 0.1);

mask_index = sPlayerShadow;

if (possesed and state != player.dead) {
	possesed_time = approach(possesed_time, possesion_complete_time, 1);	
	
	if (possesed_time == possesion_complete_time and state != player.dead) {
		if (instance_number(object_index) == 1) {
			state = player.dead;
			image_index = 0;
			sprite_index = sPlayerDieDown;
			hp = 0;	
			play_sound(sndPlayerHurt, 1, false, 1.0, 0.1, sound_effect_volume);	
		} else {
			if global.oldest_player == id {
				for (var i = 0; i < instance_number(oPlayer); i++) {
					global.oldest_player = instance_find(oPlayer, i);
					
					if (global.oldest_player.state != player.dead) break;
				}

			}
			
			//if (global.oldest_player != id) {
				play_sound(sndPlayerHit, 40, false, 1.25, 0.1, sound_effect_volume);	
			
				instance_destroy();
				instance_create_layer(x,y,layer,oImp);
		//	} else {
		//		state = player.dead;
		//		image_index = 0;
		//		sprite_index = sPlayerDieDown;
		//		hp = 0;	
		//		play_sound(sndPlayerHurt, 1, false, 1.0, 0.1, sound_effect_volume);	
		//	}
		}
		
	}
	
	//log(string(image_index));

} else {
	if (global.oldest_player != id) {
		image_xscale = lerp(image_xscale, sign(image_xscale), 0.4);
		image_yscale = lerp(image_yscale, 1.0, 0.4);
		erase_me--;
	
		if (erase_me == 0 and state != player.dead) {
			state = player.dead;
			image_index = 0;
			sprite_index = sPlayerDieDown;
			play_sound(sndPlayerHurt, 40, false, 1.25, 0.1, sound_effect_volume);
		}
	}
	possesed_time = 0;	
}



#region input
var move_x_axis, move_y_axis, input_direction, input_magnitude, attack_button_released, attack_button_charge, spell_button_released, spell_button_charge, dash_button_released, dash_button_charge;
var key_pause;


if (global.gamepad_connected) {
	move_x_axis = gamepad_axis_value(global.gamepad_slot, gp_axislh) + (g_check(0, gp_padr) - g_check(0, gp_padl));
	move_y_axis = gamepad_axis_value(global.gamepad_slot, gp_axislv) + (g_check(0, gp_padd) - g_check(0, gp_padu));
	
	camera_x_axis = gamepad_axis_value(global.gamepad_slot, gp_axisrh) * 0.25;
	camera_y_axis = gamepad_axis_value(global.gamepad_slot, gp_axisrv) * 0.25;;

	attack_button_released = g_check_r(global.gamepad_slot, gp_face3) or g_check_r(global.gamepad_slot, gp_shoulderrb);
	attack_button_charge = g_check(global.gamepad_slot, gp_face3) or g_check(global.gamepad_slot, gp_shoulderrb);
	
	dash_button_released = g_check_r(global.gamepad_slot, gp_face1) or g_check_r(global.gamepad_slot, gp_shoulderlb);
	dash_button_charge = g_check(global.gamepad_slot, gp_face1) or g_check(global.gamepad_slot, gp_shoulderlb);
	//in_control_of_camera = true;
	
	key_pause = g_check_p(global.gamepad_slot, gp_start);
} else {
	move_x_axis = check(vk_d) - check(vk_a);
	move_y_axis = check(vk_s) - check(vk_w);

	//var targ_x = window_get_width()/2; var targ_y = window_get_height()/2;
	//var mouse_speed = 2.0;
	camera_x_axis = (check(vk_e) - check(vk_q)) * 0.25;//clamp((window_mouse_get_x() - targ_x)/13, -mouse_speed, mouse_speed)// * (state == player.idle);
	camera_y_axis = 0//clamp((window_mouse_get_y() - targ_y)/13, -mouse_speed, mouse_speed)// * (state == player.idle);
	
	var margin = 120;
	if !(room == rTitle or instance_exists(oPause)) {
		window_mouse_set(clamp(window_mouse_get_x(), margin, window_get_width()-margin),
					 clamp(window_mouse_get_y(), margin, window_get_height()-margin));
	}
	
	attack_button_released = mouse_check_button_released(mb_left) or check_r(vk_j);
	attack_button_charge = mouse_check_button(mb_left) or check(vk_j);
	
	dash_button_released = mouse_check_button_released(mb_right) or check_r(vk_k); 
	dash_button_charge   = mouse_check_button(mb_right)		  or check(vk_k);  
	//in_control_of_camera = false;
	
	key_pause = check_p(vk_escape);
}

if (key_pause and room != rTitle) {
	instance_create_layer(x,y,layer,oPause);	
}

spell_button_released = false;
spell_button_charge   = false;

attack_button_released *= !hover;
attack_button_charge   *= !hover;
dash_button_released   *= !hover;
dash_button_charge     *= !hover;
					   
input_direction =		point_direction(0,0,move_x_axis,move_y_axis); // move relative to view angle
input_magnitude = clamp(point_distance( 0,0,move_x_axis,move_y_axis), 0, 1) * !hover;

if (input_magnitude != 0)
	move_direction = angle_lerp(move_direction, input_direction, 0.4) + irandom_range(-possesed_time/7, possesed_time/7);
	
if global.gamepad_connected {
	mouse_direction = move_direction - oCamera.angle + irandom_range(-possesed_time/7, possesed_time/7);	
} else {
	mouse_direction = point_direction(x,y,mouse_x,mouse_y) + irandom_range(-possesed_time/7, possesed_time/7);
}
	
	
if (attack_button_charge and charge_unlocked) {
	//if (get_data("flowers", 0) > floor(charge_time * 3/charge_max)) {
		charge_time = approach(charge_time, charge_max, 1);
		
		if (charge_time > charge_max/3) {
			for (var i = 0; i < 10; i++) {
				part_particles_create(magic_particles, x + lengthdir_x(15, i * 36), y + lengthdir_y(15, i * 36), dark_magic_particle, chance(power(charge_time/charge_max, 2) * 10) and (charge_time == charge_max));	
				part_particles_create(magic_particles, x + lengthdir_x(11, i * 36), y + lengthdir_y(11, i * 36), magic_particle, chance(power(charge_time/charge_max, 2) * 40));
				
			}
		}
//	}
} 

if (spell_button_charge and shield_unlocked and get_data("flowers", 0) > 3 and shield_timer <= 0 and !shield_active) {
	spell_time = approach(spell_time, spell_max, 1);
		
	var radius = 17 * spell_time/spell_max;
	for (var i = 0; i < 4; i++) {
		part_particles_create(magic_particles, x + lengthdir_x(radius, i * 90), y + lengthdir_y(radius, i * 90), shield_particle, chance(power(spell_time/spell_max, 2) * 40));	
	}
		
	if (spell_time == spell_max) {
		shield_active = true;
		shield_timer = shield_cooldown;
		teleport_alarm = 15; //disable teleport on release
		//global.save_data[? "flowers"] -= 3;
	}

}  else {
	spell_time = 0;	
}

if (shield_active) {
	var radius = 17;
	for (var i = 0; i < 4; i++) {
		part_particles_create(magic_particles, x + lengthdir_x(radius, i * 90), y + lengthdir_y(radius, i * 90), shield_particle, chance(60));	
	}
}

if (teleport_alarm <= 0 and dash_button_charge and dash_unlocked) {
	var xx = x; var yy = y;
	move(dash_distance, mouse_direction, false);
	part_particles_create(magic_particles, x, y, dark_magic_particle, chance(25));
			
	x = xx; y = yy;
	//teleport_alarm = teleport_cooldown;

}
#endregion

#region states

if (state == player.idle or state == player.walk) {
	if attack_alarm <= 0 and attack_button_released and throw_unlocked {
		attack_alarm = attack_cooldown;	
		oCamera.screenshake = 0.25;
	
		var charge = floor(charge_time * 3/charge_max);
		charge_time = 0;
	
		//if (get_data("flowers", 0) >= charge) {
		//	//global.save_data[? "flowers"] -= charge;
		//} else {
		//	charge = 0;	
		//}
	
		play_sound(sndBoneLaunch, 20, false, 1.0, 0.1, sound_effect_volume);
		//play_sound(sndBoneLaunchMagic, 10, false, 1.0, 0.2, 0.1 * sound_effect_volume);
		with instance_create_layer(x,y,layer,oBone) {
			direction = other.mouse_direction;
			image_speed *= -1 * other.image_xscale;
			image_xscale = other.image_xscale * 0.5;
		
			flower_charged = charge;
		}
	
		move_speed *= 0.5;
	}
	
	if (teleport_alarm <= 0 and dash_button_released and dash_unlocked and get_data("flowers", 0) >= dash_price) {
		//global.save_data[? "flowers"] -= dash_price;
		teleport_alarm = teleport_cooldown;
		play_sound(sndPlayerDash, 19, false, 1.0, 0.1, sound_effect_volume);
		
		var xpre = x, ypre = y;
		instance_deactivate_object(oMagicFireHitbox); // let them dash through fire
		move(dash_distance, mouse_direction, false);
		instance_activate_object(oMagicFireHitbox);

		while (xpre != x and ypre != y) {
			part_particles_create(magic_particles, xpre + irandom_range(-4, 4), ypre + irandom_range(-4, 4), magic_particle, 1 + chance(10))	
			xpre = lerp(xpre, x, 0.7); ypre = lerp(ypre, y, 0.7)
		}
	}
}

if attack_button_released {
	charge_time = 0;	
}

if (just_hit > 0) just_hit--;

if (check_p(vk_up) and LEVEL_EDITOR_ENABLED) {
	just_hit = 30;
	hp--;
	if (hp < 0) {
		hp = 3;
		state = player.walk;	
		image_speed = 1;	
	}
}

if (check_p(vk_left) and LEVEL_EDITOR_ENABLED) {
	global.save_data[? "flowers"] = 200;
}

if hp <= 0 and state != player.dead {
	if (instance_number(object_index) == 1) {
		state = player.dead;
		image_index = 0;
		sprite_index = sPlayerDieDown;
		hp = 0;	
		play_sound(sndPlayerHurt, 1, false, 1.0, 0.1, sound_effect_volume);	
	} else {
		global.oldest_player = instance_furthest(x,y,object_index);
		state = player.dead;
		image_index = 0;
		sprite_index = sPlayerDieDown;
		play_sound(sndPlayerHurt, 40, false, 1.25, 0.1, sound_effect_volume);	
	}
}

switch state {
	#region stationary states
	case player.idle  :
		if (face_index < 1) {
			face_index += random(0.0025);
		} else {
			face_index += 0.16;	
			if (face_index > 3) face_index = 0;
		}

		if (input_magnitude != 0) state = player.walk;
		
		move_speed = approach(move_speed, 0, 0.35);
		
		if (!global.gamepad_connected)
			move_direction = mouse_direction + oCamera.angle;
		
		
		if (dsin(move_direction) > 0) {
			sprite_index = sPlayerIdleUp;
		} else {
			sprite_index = sPlayerIdleDown;
		}
		
		if (dcos(move_direction) != 0) {
			image_xscale = sign(dcos(move_direction));
		}
		
		hand_sprite = sBoneIdle;
		
		idle_time++;
		
	break;
	#endregion 
	
	#region walking
	case player.walk  : 	
		idle_time = 0;
	
		move_speed = approach(move_speed, move_speed_max, 0.2);
		hand_sprite = sBoneWalk;

		if (dcos(move_direction) != 0) {
			image_xscale = sign(dcos(move_direction));
		}
		
		if (dsin(move_direction) > 0) {
			sprite_index = sPlayerWalkUp;
		} else {
			sprite_index = sPlayerWalkDown;
		}
		
		if (input_magnitude == 0) state = player.idle;
		
		if (ceil(image_index) == 2 or ceil(image_index) == 4) and id == global.oldest_player {
			if !made_footstep {
				made_footstep = true;
				
				if (ceil(image_index) == 2) {
					var xx = x + lengthdir_y(-4, move_direction);
					var yy = y + lengthdir_x(-4, move_direction);
					var xscale = 1;
				} else {					  
					var xx = x + lengthdir_y( 4, move_direction);
					var yy = y + lengthdir_x( 4, move_direction);
					var xscale = -1;
				}
				
				play_sound(sndGrassFootstep, 0, false, 1.5, 0.4, 0.15 * sound_effect_volume);
				
				with instance_create_layer(xx, yy, layer, oPlayerFootprint) {
					z = other.z;
					image_angle = other.move_direction;
					image_xscale = xscale;
				}
			}
		} else {
			made_footstep = false;
		}
	break;
	#endregion
	
	#region talking
	case player.talk: 
		if (face_index < 1) {
			face_index += random(0.0025);
		} else {
			face_index += 0.16;	
			if (face_index > 3) face_index = 0;
		}
		
		move_speed = approach(move_speed, 0, 0.35);
		
		hand_sprite = sBoneIdle;
		if (dsin(move_direction) > 0) {
			sprite_index = sPlayerIdleUp;
		} else {
			sprite_index = sPlayerIdleDown;
		}
		
		if (dcos(move_direction) != 0) {
			image_xscale = sign(dcos(move_direction));
		}
	break;
	#endregion
	
	#region dead
	case player.dead:
		if global.oldest_player == id and instance_number(oPlayer) > 1 {
			for (var i = 0; i < instance_number(oPlayer); i++) {
				var inst = instance_find(oPlayer, i);
				
				if (inst.state == player.dead) continue;
				
				global.oldest_player = inst;
					
				break;
			}
			
			if (global.oldest_player != id) {
				instance_destroy();
				instance_create_layer(x,y,layer,oBones);
			}
		}	
	
		if (image_index >= 6) {
			//if image_speed != 0 {
			//	var inst;
			//	for (var i = 0; i < 360; i += 45) {
			//		inst = instance_create_layer(x + lengthdir_x(30, i), y + lengthdir_y(30, i), layer, oCrow);	
			//		inst.flying = true;	
			//	}
			//}
			
			if global.oldest_player == id and (attack_button_released or dash_button_released) {
				room_restart();	
			}
			
			image_speed = 0;
		} else {
			image_speed = 1;	
		}
		
		var inst = instance_place(x,y,oBone);
		if (inst and instance_number(object_index) > 1 and global.oldest_player != id) {
			instance_destroy(inst);
			instance_destroy();
			repeat(7)
				instance_create_layer(x + irandom_range(-12, 12),y + irandom_range(-12, 12),layer, oDustParticle);
		}
		
		if (place_meeting(x,y,oBonesplosion) and instance_number(object_index) > 1 and global.oldest_player != id) {
			instance_destroy();
			repeat(7)
				instance_create_layer(x + irandom_range(-12, 12),y + irandom_range(-12, 12),layer, oDustParticle);
		}
		
		move_speed = approach(move_speed, 0, 0.25);
	break;
	#endregion
}
#endregion

if (attack_alarm > 0) {
	attack_alarm--;
} 

if (teleport_alarm > 0) {
	teleport_alarm--;	
	
	if (teleport_alarm > 5 * teleport_cooldown/6) {
		for (var i = 0; i < 10; i++) {
			part_particles_create(magic_particles, x + lengthdir_x(15, i * 36), y + lengthdir_y(15, i * 36), dark_magic_particle, chance(teleport_alarm * 0.05));	
			part_particles_create(magic_particles, x + lengthdir_x(15, i * 36), y + lengthdir_y(15, i * 36), magic_particle, chance(teleport_alarm * 0.2));	
		}
	}
}

if (shield_timer > 0) {
	shield_timer--;	
}

// rotate camera

if (in_control_of_camera) {
	oCamera.angle			+= camera_x_axis;
	oCamera.image_zscale	+= camera_y_axis * 0.01;
}

move(input_magnitude * move_speed, move_direction - oCamera.angle);
