/// @description

if (instance_exists(oPause) or global.oldest_player.state == player.dead) exit;

switch state {
	case imp.spawn:
	sprite_index = sImpSpawn;
	if (ceil(image_index) == image_number) {
		state = imp.chase;	
	}
	break;
	case imp.chase:
	mask_index = sPlayerShadow;
	var inst = instance_nearest(x,y,oPlayer);
	
	if (target_timer == 0) {
		target_timer = 5;
		target_direction = point_direction(x, y, inst.x, inst.y) + irandom_range(-15, 15);
	}
	target_timer--;
	
	chase_direction = angle_lerp(chase_direction, target_direction, 0.45);	
	chase_speed = approach(chase_speed, chase_speed_max, chase_speed_accel);
	
	move(chase_speed, chase_direction);
	
	if (distance_to_object(oPlayer) < 6) {
		state = imp.swing;
		image_index = 0;
		image_speed = 1;
		
		play_sound(sndPlayerHit, 30, false, 0.75, 0.1, sound_effect_volume);
		
		if (sprite_index == sImpUp) {
			sprite_index = sImpUpAttack;
		} else {
			sprite_index = sImpDownAttack;	
		}
	}
	
	if (dsin(chase_direction + oCamera.angle) > 0) {
		sprite_index = sImpUp
	} else {
		sprite_index = sImpDown	
	}
	if (dcos(chase_direction + oCamera.angle) != 0) {
		image_xscale = sign(dcos(chase_direction + oCamera.angle));
	}
	if (ceil(image_index) == 3 or ceil(image_index) == 4) {
		if !made_footstep {
			made_footstep = true;
				
			play_sound(sndGrassFootstep, 0, false, 1.0, 0.4, 0.15 * sound_effect_volume);			
		}
	} else {
		made_footstep = false;
	}
	
	break;
	case imp.swing:
	chase_speed = approach(chase_speed, 0, chase_speed_decel);
	move(chase_speed, chase_direction);
	
	if (dsin(chase_direction + oCamera.angle) > 0) {
		sprite_index = sImpUpAttack
	} else {
		sprite_index = sImpDownAttack
	}
	if (dcos(chase_direction + oCamera.angle) != 0) {
		image_xscale = sign(dcos(chase_direction + oCamera.angle));
	}
	
	if (ceil(image_index) == 2) {
		mask_index = sprite_index;
		var inst = instance_place(x,y,oPlayer);
		if (inst and inst.just_hit <= 0) {	
			inst.hp -= 1.0;
			inst.just_hit = 30;
			if (inst.state == player.dead and inst != global.oldest_player) instance_destroy(inst);
			
			oCamera.screenshake = .1;
			play_sound(sndPlayerHit, 25, false, 1.0, 0.2, sound_effect_volume);	
		}
	}
	
	if (image_index >= 3.8) {
		state = imp.chase;
	}
	break;
}

var inst = instance_place(x,y,oBone);
if (inst) {
	instance_destroy(inst);
}

if (place_meeting(x,y,oBonesplosion)) {
	play_sound(sndPlayerHit, 30, false, 0.5, 0.1, sound_effect_volume);
	play_sound(sndRogueDarkVoice, 30, false, 1.1, 0.1, sound_effect_volume);
	
	instance_destroy();	
}

mask_index = sPlayerShadow;