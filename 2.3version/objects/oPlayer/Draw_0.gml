/// @description

if (just_hit > 0) and (floor(just_hit/2) mod 2 == 1) and hp > 0{
	exit;
}

if hover {
	image_speed = 0.5;
	draw_sprite_ext(hover_sprite, image_index, oShrine.x, oShrine.y, abs(image_xscale), image_yscale, -oCamera.angle, image_blend, image_alpha);
	exit;
} 
//depth = compute_3d_depth(x, y, z) - 2000; //bad, uses too many layers

var redshift = possesed and (possesed_time > possesion_complete_time/2);

if (redshift) {
	shader_set(shdRedShift);
	//shader_set_uniform_f(redshift_uniform, possesed_time/possesion_complete_time);
}	

if (global.oldest_player == id) {
	var draw_key_gui = false;
	if (last_keys != get_data("keys", 0)) {
		draw_key_gui = true;
		key_gui_scale = lerp(key_gui_scale, 1.0, 0.1);

	} else if key_gui_scale > 0 {
		draw_key_gui = true;
		key_gui_scale = lerp(key_gui_scale, 0.0, 0.1);
		flower_gui_scale = lerp(flower_gui_scale, 0.0, 0.1);
	}
	if (draw_key_gui and global.hide_gui == false) {
		last_keys = lerp(last_keys, get_data("keys", 0), 0.1);
		draw_billboarded_sprite(sKeyyIcon, image_index, x, y, sprite_height, abs(image_xscale) * 0.5 * key_gui_scale, image_yscale * 0.5 * key_gui_scale, 0, image_blend, image_alpha)
	
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		var c = make_color_rgb(35, 12, 69);
		draw_text_transformed_color(x - (sprite_height-5) * oCamera.x_step * oCamera.image_zscale, y - (sprite_height-5) * oCamera.y_step * oCamera.image_zscale, string(get_data("keys", 0)), key_gui_scale, key_gui_scale * oCamera.image_zscale, -oCamera.angle, c, c, c, c, 1.0);
																														  						  																		   	  					
		c = make_color_rgb(255, 255, 247);																					  				  																			    						
		draw_text_transformed_color(x - (sprite_height-4) * oCamera.x_step * oCamera.image_zscale, y - (sprite_height-4) * oCamera.y_step * oCamera.image_zscale, string(get_data("keys", 0)), key_gui_scale, key_gui_scale * oCamera.image_zscale, -oCamera.angle, c, c, c, c, 1.0);
	
	} 


	var draw_flower_gui = false;
	if (last_flowers != get_data("flowers", 0)) {
		draw_flower_gui = true;
		flower_gui_scale = lerp(flower_gui_scale, 1.0, 0.1);

	} else if flower_gui_scale > 0 {
		draw_flower_gui = true;
		flower_gui_scale = lerp(flower_gui_scale, 0.0, 0.1);
	}

	draw_flower_gui = draw_flower_gui and !draw_key_gui;

	if (draw_flower_gui and global.hide_gui == false) {
		last_flowers = lerp(last_flowers, get_data("flowers", 0), 0.1);
		draw_billboarded_sprite(sSunflowerIcon, image_index, x, y, sprite_height, abs(image_xscale) * 0.5 * flower_gui_scale, image_yscale * 0.5 * flower_gui_scale, 0, image_blend, image_alpha)
	
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		var c = make_color_rgb(35, 12, 69);
		draw_text_transformed_color(x - (sprite_height-5) * oCamera.x_step * oCamera.image_zscale, y - (sprite_height-5) * oCamera.y_step * oCamera.image_zscale, string(get_data("flowers", 0)), flower_gui_scale, flower_gui_scale * oCamera.image_zscale, -oCamera.angle, c, c, c, c, 1.0);
																													  						  																							  					
		c = make_color_rgb(255, 255, 247);																				  				  																							 						
		draw_text_transformed_color(x - (sprite_height-4) * oCamera.x_step * oCamera.image_zscale, y - (sprite_height-4) * oCamera.y_step * oCamera.image_zscale, string(get_data("flowers", 0)), flower_gui_scale, flower_gui_scale * oCamera.image_zscale, -oCamera.angle, c, c, c, c, 1.0);
	
	} 
}

if (possesed) {
	if (state != player.dead or global.oldest_player == id) {
		var yoff = 0;
		yoff += possesed_time * 1.0/60;
	
		if (sprite_index == sPlayerWalkUp or sprite_index == sPlayerWalkDown) and (ceil(image_index) == 2 or ceil(image_index) == 4) {
			yoff += 4;
		}
	
		draw_billboarded_sprite(sShadowPossesion, image_index, x, y, yoff, image_xscale, image_yscale, 0, image_blend, image_alpha)
	}
} else if global.oldest_player == id {
	if global.dark[room] {
		draw_billboarded_sprite(sPlayerShadowDark, image_index, x, y, 0, abs(image_xscale), image_yscale, 0, image_blend, image_alpha)
	} else {
		draw_billboarded_sprite(sPlayerShadow, image_index, x, y, 0, abs(image_xscale), image_yscale, 0, image_blend, image_alpha)
	}
}


if (state == player.dead) {
	draw_billboarded_sprite(sprite_index, image_index, x, y, z, image_xscale, image_yscale, 0, image_blend, image_alpha);
	exit;
}

var hand_scale = clamp((attack_cooldown/2-attack_alarm)/(attack_cooldown/2), 0, 1);
if (hand_scale < 0.4) hand_scale = 0;

var actual_sprite = sprite_index;

switch(sprite_index) {
	case sPlayerIdleDown: 
		switch ceil(hp) {
			case 2: actual_sprite = sPlayerCrack2IdleDown; break;
			case 1: actual_sprite = sPlayerCrack3IdleDown; break;
		}
	break;
	case sPlayerIdleUp: 
		switch ceil(hp) {
			case 2: actual_sprite = sPlayerCrack2IdleUp; break;
			case 1: actual_sprite = sPlayerCrack3IdleUp; break;
		}
	break;
	case sPlayerWalkDown: 
		switch ceil(hp) {
			case 2: actual_sprite = sPlayerWalkDownCrack2; break;
			case 1: actual_sprite = sPlayerWalkDownCrack3; break;
		}
	break;
	case sPlayerWalkUp: 
		switch ceil(hp) {
			case 2: actual_sprite = sPlayerWalkUpCrack2; break;
			case 1: actual_sprite = sPlayerWalkUpCrack3; break;
		}
	break;
}

draw_billboarded_sprite(hand_sprite, image_index, x, y, z, image_xscale * hand_scale, image_yscale * hand_scale, 0, image_blend, image_alpha);

draw_billboarded_sprite(actual_sprite, image_index, x, y, z, image_xscale, image_yscale, 0, image_blend, image_alpha);

if ((state == player.idle or state == player.talk) and sprite_index == sPlayerIdleDown) {

	draw_billboarded_sprite(sPlayerFace, face_index, x, y, z, image_xscale, image_yscale, 0, image_blend, image_alpha);
}

if (redshift) {
	shader_reset();
	
} 


//draw_text(xstart, ystart, "Skele In The Forest");