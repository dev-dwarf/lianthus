/// @description

if (instance_exists(oPause) or global.oldest_player.state == player.dead) exit;

mask_index = sShadowRogue;

if state != rogue.dead {
	switch state {
		case rogue.appear: 
			sprite_index = sShadowRogueVanish;
			image_speed = -1;
			
			if (image_index < 0.5) {
				image_speed = 1;
				state = rogue.idle;	
			}
		break;
		case rogue.idle	 : 
			sprite_index = sShadowRogue;
			
			aim_direction = point_direction(x,y,global.oldest_player.x, global.oldest_player.y);
			
			aim_clock--;
			if (aim_clock == 0) {
				aim_clock = aim_time;	
				image_index = 0;
				shots = 3;
				state = rogue.shoot;
			}
		break;
		case rogue.shoot : 
		sprite_index = sShadowRogueAttack;
		
		if (ceil(image_index) == 3) {
			if (!shot) {
				shots--;
				shot = true;
			
				play_sound(sndRogueDarkThrow, 0, false, 1.0, 0.1, sound_effect_volume);
				
				var inst = instance_create_layer(x,y,layer,oShadowRogueKnife);
				inst.direction = aim_direction;
				
				if (shots == 0) {
					var inst = instance_create_layer(x,y,layer,oShadowRogueKnife);
					inst.direction = aim_direction + 30;
					var inst = instance_create_layer(x,y,layer,oShadowRogueKnife);
					inst.direction = aim_direction - 30;
				}
					
			} 
		
			if (shots == 0) {
				state = rogue.vanish;	
				image_index = 0;
			}
		} else {
			aim_direction = lerp(aim_direction, point_direction(x, y, global.oldest_player.x, global.oldest_player.y), aim_speed);
		
			shot = false;	
		}
		break;
		case rogue.vanish: 
		sprite_index = sShadowRogueVanish;
			
		if (image_index > 3.5) {
			do {
				var angle = last_angle + irandom(330/30)*30 + 30;
			
				x = oShadow.x + lengthdir_x(95, angle);
				y = oShadow.y + lengthdir_y(95, angle);
				
				last_angle = angle;
			} until (!place_meeting(x,y,oPlayer));
			
			image_index = 4.0;
			state = rogue.appear;	
		}
		break;
		case rogue.dying : 
		
		break;
	}
} else {
	
}

if (dcos(aim_direction + oCamera.angle) != 0) {
	if (distance_to_object(global.oldest_player) > 10) {
		image_xscale = sign(dcos(aim_direction + oCamera.angle));
	}
}

//log(string(hp));