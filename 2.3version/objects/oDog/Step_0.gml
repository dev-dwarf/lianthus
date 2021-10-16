/// @description
if !global.dark[room] {
	exit;	
	
}

if (instance_exists(oPause)) exit;


if (wait > 0) {	
	wait--;
	wait_speed = approach(wait_speed, 0, 1);
	
	if (state == dog.vanish) {
		var away_dir = point_direction(x,y,oPlayer.x,oPlayer.y);
		with oPlayer {
			x += lengthdir_x(other.wait_speed, away_dir);
			y += lengthdir_y(other.wait_speed, away_dir);
		}
	}
	exit;
}

switch state {
	case dog.chase	: #region chase state
			sprite_index = sDogDark;
			mask_index = sDogDark;

		oOrb.active = false;
		oOrb.sprite_index = sOrbDeactive;
		if oPlayer.state = player.dead {
			if (audio_is_playing(sndDogGrowl)) {
				audio_sound_gain(sndDogGrowl, 0, 1000);	
			}
			exit;
		}
		
		if (!audio_is_playing(sndDogGrowl)) {
			play_sound(sndDogGrowl, 60, false, 1.0, 0.0, 0.85 * sound_effect_volume);
		}
		
		if (distance_to_object(oPlayer) < attack_range) {
			if (attack_timer <= 0) {
				state = dog.attack;
				
				
				attack_timer = attack_timer_max;
				attack_hit_this_time = false;
				attack_accelerated = false;
				chase_attack_count--;
				chase_speed = 0;
				sprite_index = sDogDarkAttack;
				image_index = 0;	
				exit;
			} else {
				attack_timer--;	
			} 
		} else {
			attack_timer-=0.25;	
		}
		
		image_index = oPlayer.image_index*(7/4);
		oPlayer.image_speed = 7/5;
		oPlayer.move_speed_max = 0.83;
		oPlayer.attack_cooldown = 30;
		chase_direction = angle_lerp(chase_direction, point_direction(x, y, oPlayer.x, oPlayer.y), 0.75);
		if (distance_to_object(oPlayer) < 25) {
			chase_speed = approach(chase_speed, chase_speed_max * 3/5, chase_accel);
			attack_timer -= 0.5;
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
				play_sound(sndDogFootstep, 10, false, 1.0, 0.1, sound_effect_volume);	
				footstep_played = true;
			}
		} else {
			footstep_played = false;	
		}
		
		camera_object.x = (x * 0.75 + oPlayer.x * 1.25)/2;	
		camera_object.y = (y * 0.75 + oPlayer.y * 1.25)/2;
		
	break; #endregion
	case dog.attack	: #region attack state
	oOrb.active = false;
	mask_index = sDogDarkAttack;
	if attack_accelerated {
		
		var inst = instance_place(x,y,oPlayer);
		if (attack_hit_this_time == false and inst and (ceil(image_index) == 8 or ceil(image_index) == 9 or ceil(image_index) == 10)) {
			inst.hp -= 0.75;
			oCamera.screenshake = .5;
			inst.just_hit = 30;
			play_sound(sndPlayerHit, 25, false, 1.0, 0.2, sound_effect_volume);
			chase_speed *= 0.75;
			
			attack_hit_this_time = true;
		}
		
		chase_speed = approach(chase_speed, 0, attack_decel);

		if (chase_speed == 0) {
			if chase_attack_count == 0 {
				// enter vanish state
				sprite_index = sDogDarkVanish
				state = dog.vanish;
				image_index = image_number;
				//image_speed = -1
			} else {
				state = dog.chase;
				sprite_index = sDogDark;
				image_index = 0;
				image_speed = 1;
			}
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
		if (chase_speed < attack_speed/2) {
			chase_direction = point_direction(x, y, oPlayer.x, oPlayer.y)
		}
		
		chase_speed = approach(chase_speed, attack_speed, attack_accel);
		image_speed = 1;
		if (chase_speed == attack_speed) {
			attack_accelerated = true;
			play_sound(sndDogDash, 0, false, 1.0, 0.0, sound_effect_volume);
				play_sound(choose(sndBark1, sndBark2, sndBark3, sndBark4), 30, false, 1.0, 0.2, sound_effect_volume);	
		}
	}

	break; #endregion
	case dog.spawn	: #region spawn little boiyos
	
	if (sprite_index == sDogDarkSummonIntro && floor(image_index) == 9) {
		sprite_index = sDogDarkSummon;
	}
	
	var cam_x = oPlayer.x * 1.25;
	var cam_y = oPlayer.y * 1.25;
	var cam_sum = 1.25;
	
	cam_x += x;
	cam_y += y;
	cam_sum += 1;
	
	with (oFireDog) {
		cam_x += x * 0.5;
		cam_y += y * 0.5;
		cam_sum += 0.5;
	}
	camera_object.x = cam_x/cam_sum;	
	camera_object.y = cam_y/cam_sum;
	
	if (!instance_exists(oMagicFire) and !instance_exists(oFireSummoner)) {
		var inst;
		play_sound(sndShadowShoot, 30, false, 1.0, 0.3, sound_effect_volume);
		play_sound(sndBark2, 30, false, 2.0, 0.4, sound_effect_volume);
		for (var i = 0; i < 360; i += 30) {
			inst = instance_create_layer(x + lengthdir_x(30, i), y + lengthdir_y(30, i), layer, oFireSummoner);	
			inst.image_angle = i + 90;
			inst.image_xscale = 0.15;
			inst.image_yscale = 0.15;
			inst.time = -1;
			inst.alarm[0] = 40;

		}	
		
		spawn_collision_instance = instance_create_layer(x,y,layer,oInvisbleWall);
		spawn_collision_instance.image_xscale = 2.0;
		spawn_collision_instance.image_yscale = 2.0;
		var away_dir = point_direction(x,y,oPlayer.x,oPlayer.y);
		with oPlayer {
			while(place_meeting(x,y,other.spawn_collision_instance)) {
				x += lengthdir_x(20, away_dir);
				y += lengthdir_y(20, away_dir);
			}
		}
	}
	
	var down = true;
	with oOrb {
		down = down & active;	
	}
	if (down == true) {
		hittable_timer = hittable_time_max;
		state = dog.hittable;
		instance_destroy(spawn_collision_instance);
		instance_destroy(oMagicFire);
		instance_destroy(oFireDog);
	} else {
		spawn_timer--;	
		
		if (spawn_timer <= 0 and instance_number(oFireDog) < 2) {
			oCamera.screenshake = .36;
			play_sound(sndBark1, 30, false, 2.0, 0.4, sound_effect_volume);
			instance_create_layer(x+irandom_range(-16, 16),y+irandom_range(-16, 16),layer,oFireDog);
			
			if (hp <= 2) {
				var inst = instance_find(oDogDoor, irandom(instance_number(oDogDoor) - 1));
				instance_create_layer(inst.x+irandom_range(-16, 16),inst.y+irandom_range(-16, 16),layer,oFireDog);
			}
			if (hp <= 1) {
				var inst = instance_find(oDogDoor, irandom(instance_number(oDogDoor) - 1));
				instance_create_layer(inst.x+irandom_range(-16, 16),inst.y+irandom_range(-16, 16),layer,oFireDog);
			}
			
			spawn_timer = spawn_timer_max - 30 * (3-hp);
		}		
	}
	break; #endregion
	case dog.vanish	: #region vanish
	if (image_speed > 0) {
		////log(string(floor(image_index)) + " : " + string(image_number-1));
		if (floor(image_index)  ==	image_number-1) {
			image_speed *= -1;
			
			x = oDogMagicCircle.x;
			y = oDogMagicCircle.y;
		//	//log("fired");
		}
	} else {
		if (floor(image_index) == 0) {
			if (initial_spawn) {
				initial_spawn = false;
				state = dog.chase;
				sprite_index = sDogDark;
			} else {
				if (made_fire) {
					state = dog.spawn;
					made_fire = false;
					oOrb.sprite_index = sOrb;
					sprite_index = sDogDarkSummonIntro;
					image_index = 0;
					image_speed = 1;
				
					instance_create_layer(x,y,layer,oFireDog);
				} else {
					state = dog.fire;
					made_fire = true;
					
					play_sound(sndShadowShoot, 30, false, 1.0, 0.3, sound_effect_volume);
					play_sound(sndBark2, 30, false, 2.0, 0.4, sound_effect_volume);
					
					for (var i = 0; i < 360; i += 30) {
						inst = instance_create_layer(x + lengthdir_x(60, i), y + lengthdir_y(60, i), layer, oFireSummoner);	
						inst.image_angle = i + 90;
						inst.image_xscale = 0.3;
						inst.image_yscale = 0.3;
					}	
				}
			}
		}
	}
	camera_object.x = (x + oPlayer.x)/2;	
	camera_object.y = (y + oPlayer.y)/2;
	break; #endregion
	case dog.fire: #region
	camera_object.x = (x * 0.75 + oPlayer.x * 1.25)/2;	
	camera_object.y = (y * 0.75 + oPlayer.y * 1.25)/2;
	sprite_index = sDogDarkSummonFire;
	fire_timer--;
	if (fire_timer <= 0) {
		play_sound(sndShadowShoot, 30, false, 1.0, 0.3, sound_effect_volume);
		play_sound(sndBark2, 30, false, 2.0, 0.4, sound_effect_volume);
		
		oCamera.screenshake = .36;
		for (var i = 0; i < 360; i += 30) {
			inst = instance_create_layer(oPlayer.x + lengthdir_x(60, i), oPlayer.y + lengthdir_y(60, i), layer, oFireSummoner);	
			inst.image_angle = i + 90;
			inst.image_xscale = 0.3;
			inst.image_yscale = 0.3;
		}	

			inst = instance_create_layer(oPlayer.x, oPlayer.y, layer, oFireSummoner);	
			inst.image_xscale = 0.5;

		
		if (hp <= 1) {
			play_sound(sndBark1, 30, false, 2.0, 0.4, sound_effect_volume);
			instance_create_layer(x+irandom_range(-16, 16),y+irandom_range(-16, 16),layer,oFireDog);	
		}
		
		fire_timer = fire_timer_max;
		fire_count--;
	}
	
	if (fire_count == 0) {
		fire_count = 0 + (3-hp);
		state = dog.chase;
		chase_attack_count = 1 + (3-hp);
		attack_timer = attack_timer_max*2;
		wait = 20;
		
		if (hp <= 2) {
			play_sound(sndBark1, 30, false, 2.0, 0.4, sound_effect_volume);
			instance_create_layer(x,y+40,layer,oFireDog);	
			instance_create_layer(x,y-40,layer,oFireDog);	

		}
	}
	
	
	break; #endregion
	case dog.hittable: #region get damaged
	sprite_index = sDogDarkHittable;
	if (place_meeting(x,y,oBonesplosion) or place_meeting(x,y,oBone)) {
		instance_destroy(oBone);
		hp--;
		oCamera.screenshake = .36;
		play_sound(sndDogDarkHurt, 50, false, 1.0, 0.2, sound_effect_volume);	
		
		if (hp > 0) {
			sprite_index = sDogDark;
			state = dog.chase;
			chase_attack_count = 1 + (3-hp);
			
			var inst;
			for (var i = 0; i < 360; i += 10) {
				inst = instance_create_layer(x + lengthdir_x(25 + irandom(10), i), y + lengthdir_y(25 + irandom(10), i), layer, oFireParticle);	
				inst.z = 9;
				inst.image_angle = i;
			}	
		} else {
			var inst;
			for (var i = 0; i < 360; i += 30) {
				inst = instance_create_layer(x + lengthdir_x(40, i), y + lengthdir_y(40, i), layer, oDogDoor);	
				inst.image_angle = i + 90;
				inst.image_xscale = 0.6;
			}	

			if !audio_is_playing(sndDogDarkDefeated) {
				play_sound(sndDogDarkDefeated, 0, false, 1.0, 0.0, sound_effect_volume);
			}
			state = dog.death;
			sprite_index = sDogDarkVanish;
			image_index = 0;
			image_speed = 0.75;
		}
	}
	
	hittable_timer--;
	if (hittable_timer <= 0) {
		sprite_index = sDogDark;
		state = dog.chase;
		chase_attack_count = 1 + (3-hp);
	}
	
	break; #endregion
	case dog.death: #region evaporate
	sprite_index = sDogDarkVanish;
	image_speed = 0.25;
	oPlayer.move_speed_max = 0.74;
	oPlayer.image_speed = 1.0;
	if (floor(image_index)  ==	image_number-1) {
		instance_destroy();	
		global.save_data[? "dog_defeated"] = true;
		ds_map_secure_save(global.save_data, SAVEFILE);
		global.recently_saved = 100;

		instance_destroy(oDogDoor);
		
		play_sound(sndDogDarkIntro, 0, false, 0.5, 0.0, sound_effect_volume * 1.2);
		instance_create_layer(0, 0, layer, oAmbiencePlayer);
	}
	
	
	break; #endregion
}

//log(string(state) + ": " + sprite_get_name(sprite_index));