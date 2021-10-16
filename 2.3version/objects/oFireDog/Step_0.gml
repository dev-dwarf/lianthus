/// @description
if (instance_exists(oPause)) exit;

if (place_meeting(x,y,oBone)) {
	instance_destroy(oBone);
	instance_destroy();
}

if (place_meeting(x,y,oBonesplosion)) {
	instance_destroy();
}

if (oPlayer.hp <= 0) exit;

switch state {
	case dog.chase	: #region chase state
	
		if (distance_to_object(oPlayer) < attack_range) {
			if (attack_timer <= 0) {
				state = dog.attack;
				play_sound(sndDogDash, 0, false, 2.0, 0.0, sound_effect_volume);
				
				attack_timer = attack_timer_max;
				attack_hit_this_time = false;
				attack_accelerated = false;
				chase_attack_count--;
				chase_speed = 0;
				sprite_index = sFireDogAttack;
				image_index = 0;
				
			} else {
				attack_timer--;	
			} 
		} else {
			attack_timer-=0.25;	
		}
		
		image_index = oPlayer.image_index*(7/4);
		chase_direction = angle_lerp(chase_direction, point_direction(x, y, oPlayer.x, oPlayer.y), 1.0);
		
		if (distance_to_object(oPlayer) < 10) {
			chase_speed = approach(chase_speed, chase_speed_max * 3/5, chase_accel);
		} else {
			chase_speed = approach(chase_speed, chase_speed_max, chase_accel);
		}
		
		#region camera
		var adjusted_angle = chase_direction + oCamera.angle;
		var camera_stretch = abs(lengthdir_x(1, adjusted_angle)) 
						   + abs(lengthdir_y(oCamera.image_zscale/oCamera.zscale_min, adjusted_angle)); 
		camera_stretch /= abs(dcos(adjusted_angle)) + abs(dsin(adjusted_angle));
		#endregion	 	
		x += lengthdir_x( chase_speed*camera_stretch, chase_direction);
		y += lengthdir_y( chase_speed*camera_stretch, chase_direction);
		
		if (dcos(chase_direction + oCamera.angle) != 0) {
			if (distance_to_object(oPlayer) > 10) {
				image_xscale = sign(dcos(chase_direction + oCamera.angle));
			} else {
				image_xscale = oPlayer.image_xscale;	
			}
		}
		
		if ((floor(image_index) == 2 and image_index < 2.5) or (floor(image_index) == 3 and image_index < 3.5)) {
			if (!footstep_played) {
				play_sound(sndDogFootstep, 40, false, 1.85, 0.1, sound_effect_volume);	
				footstep_played = true;
			}
		} else {
			footstep_played = false;	
		}
		
	break; #endregion
	case dog.attack	: #region attack state
	if attack_accelerated {
		var inst = instance_place(x,y,oPlayer);
		if (attack_hit_this_time == false and inst) {
			inst.hp -= 0.5;
			oCamera.screenshake = .1;
			inst.just_hit = 30;
			play_sound(sndPlayerHit, 25, false, 1.0, 0.2, sound_effect_volume);
			
			chase_speed *= 0.5;
			
			attack_hit_this_time = true;
		}
		
		chase_speed = approach(chase_speed, 0, attack_decel);

		if (chase_speed == 0) {
			
			instance_destroy();
		}
		#region camera 
		var adjusted_angle = chase_direction + oCamera.angle;
		var camera_stretch = abs(lengthdir_x(1, adjusted_angle)) 
						   + abs(lengthdir_y(oCamera.image_zscale/oCamera.zscale_min, adjusted_angle)); 
		camera_stretch /= abs(dcos(adjusted_angle)) + abs(dsin(adjusted_angle));
		#endregion	  
		x += lengthdir_x( chase_speed*camera_stretch, chase_direction);
		y += lengthdir_y( chase_speed*camera_stretch, chase_direction);
	} else {
		chase_speed = approach(chase_speed, attack_speed, attack_accel);
		image_index = 0;
		if (chase_speed == attack_speed) {
			attack_accelerated = true;
			play_sound(choose(sndBark1, sndBark2, sndBark3, sndBark4), 30, false, 1.5, 0.2, sound_effect_volume);	
		}
	}
	break; #endregion
}