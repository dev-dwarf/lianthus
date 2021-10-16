/// @description
//if (LEVEL_EDITOR_ENABLED) exit;

//image_xscale = 1.5;
//image_yscale = 1.5;
//if (place_meeting(x,y,oPlayer)) {
//	move_speed = oPlayer.move_speed * 4;
//	move_direction = oPlayer.move_direction + irandom_range(-10, 10);
//}
//image_xscale = 1.0;
//image_yscale = 1.0;

if (!instance_exists(global.oldest_player)) exit;
if (broken or global.oldest_player.state == player.dead) exit;

move_speed = approach(move_speed, 0, 0.2);
image_angle += move_speed;

x += lengthdir_x(move_speed, move_direction - oCamera.angle);
y += lengthdir_y(move_speed, move_direction - oCamera.angle);

if (place_meeting(x,y, oBonesplosion)) and !broken {
	// create particles	
	var r = sprite_width/2
	repeat(1 + chance(30) + chance(20))
		instance_create_layer(x + random_range(-r, r), y + random_range(-r, r), layer, oDustParticle);
		
	instance_destroy(collision_instance);
	broken = true;
}

if (distance_to_object(oPlayer) < 20) and !broken {
	if (global.oldest_player.clone_unlocked) {
		image_xscale = lerp(image_xscale, 1.3, 0.4);
		image_yscale = lerp(image_xscale, 1.3, 0.4);
		sprite_index = sSkullActive;

		if (z == 0) {
			var r = sprite_width/2
			repeat(3)
				instance_create_layer(x + random_range(-r, r), y + random_range(-r, r), layer, oFireParticle);
			go_up = true;
			play_sound(sndSkullJumpy, 50, false, 1.5, 0.2, sound_effect_volume);	
		} else {
		
			image_angle += 2.5 * !LEVEL_EDITOR_ENABLED;
		}
	
		if (go_up) {
			z = lerp(z, 10, 0.35);
			if (z > 7.9) go_up = false;	
		}
	
		var clone_pressed = false;
		if (global.gamepad_connected) {
			clone_pressed = g_check_p(global.gamepad_slot, gp_face4) or g_check_p(global.gamepad_slot, gp_shoulderl);
		} else {
			clone_pressed = check_p(vk_shift) or check_p(vk_space);
		}
	
		if (clone_pressed) {
			instance_destroy();
			if (instance_exists(collision_instance))
				instance_destroy(collision_instance);
			instance_create_layer(x,y,layer,oPlayer);
			play_sound(sndSkullJumpy, 0, false, 1.0, 0.0, sound_effect_volume);	
			play_sound(sndSkullClone, 0, false, 1.0, 0.0, sound_effect_volume);	

		}
	}
} else {
	image_xscale = lerp(image_xscale, 1.0, 0.7);
	image_yscale = lerp(image_xscale, 1.0, 0.7);
	sprite_index = sSkull;
	go_up = false;
}

if (!go_up)
	z = approach(z, 0, 1.6/max(z,1));	