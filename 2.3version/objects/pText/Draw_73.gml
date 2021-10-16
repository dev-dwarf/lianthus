///// @description
//if (global.hide_gui) {
////	instance_destroy();	
//	exit;
//}

if adjust {
	adjust--
	image_angle = -oCamera.angle;
	x = oCamera.x + oCamera.x_step * pos;
	y = oCamera.y + oCamera.y_step * pos;
}

if (text_index <= string_length(text)) {
	var last = text_index;
	text_index = clamp(text_index + text_speed, 0, string_length(text));
	
	displayed_text = string_copy(text, 0, text_index);
	
	if voice != noone and floor(last) < floor(text_index) and !char_is_grammar(string_char_at(text, text_index)) {
		if (alt_voice != noone and chance(20)) {
			play_sound(alt_voice, 50, false, 1.0, 0.35, sound_effect_volume);	
		} else {
			play_sound(voice, 50, false, 1.0, 0.35, sound_effect_volume);	
		}
		text_index = floor(text_index);
	}	
}

if (text_index >= max_chars and child_inst == noone and string_char_at(text, text_index) == " ") {
	child_inst = instance_create_layer(x,y,layer,pText);
	child_inst.destroy = destroy;
	child_inst.text = string_copy(text, text_index, string_length(text));
	child_inst.pos = pos + (string_height("M") - 5) * oCamera.image_zscale/oCamera.zscale_min;
	child_inst.voice = voice;
	child_inst.text_speed = text_speed;
		
	text = string_copy(text, 0, text_index);
	last_text = text;
		
}

if (last_text != text) {
	if (instance_exists(child_inst) and child_inst != noone) {
		instance_destroy(child_inst);
		child_inst = noone;
	}
	
	last_text = text;
}


if destroy > 0 {
	destroy--;
} else if (destroy == 0) {
	instance_destroy();
	
	
}

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if (outline) {
	if (global.dark[room]) {
		draw_set_color(make_color_rgb(255, 0, 89));	
	} else {
		draw_set_color(make_color_rgb(35, 12, 69));	
	}
	draw_text_transformed(x + oCamera.x_step * oCamera.image_zscale, y + oCamera.y_step * oCamera.image_zscale, displayed_text, 1.0, 1.0 * oCamera.image_zscale, image_angle);
	//draw_text_transformed(x + oCamera.x_step * 2, y + oCamera.y_step * 2, displayed_text, 0.5 * image_xscale, 0.5 * image_yscale * oCamera.image_zscale, image_angle);
}

draw_set_color(color);
draw_text_transformed(x, y, displayed_text, 1.0, 1.0 * oCamera.image_zscale, image_angle);

//draw_text_transformed(x, y, displayed_text, 0.5 * image_xscale, 0.5 * image_yscale * oCamera.image_zscale, image_angle);


