/// @description moved to end step to avoid angling sprites during camera angle changes

if !last_focused and window_has_focus() {
	#region resize window
	global.set_window = false
	window_set_fullscreen(fullscreen);

	#endregion	
}
last_focused = window_has_focus();


// change fonts
//if (oPlayer.image_index < 2) {
	draw_set_font(sFontInternational);
//} else {
//	draw_set_font(sFont2);
//}

// debug stuff to rotate and change z_scale
//angle += 0.5;

// compute coords for drawing the stacked sprites, change to vector eventually
x_step = dcos(90 + angle);
y_step = dsin(90 + angle);

if (instance_exists(global.oldest_player)) {
	target_x  =  global.oldest_player.x;
	target_y  =  global.oldest_player.y;
	
	var set_target = false;
	with (global.oldest_player) {
		var inst = instance_nearest(x,y,oPointOfInterest);
		set_target = inst and point_distance(inst.x, inst.y, x, y) < 85;
	}
	if (set_target) {
		target_x = inst.x;
		target_y = inst.y;
		angle = angle_lerp(angle, inst.image_angle, 0.015);	
		image_zscale = lerp(image_zscale, clamp(inst.image_xscale, zscale_min, zscale_max), 0.015);
	}
	
	if (target_x == global.oldest_player.x and target_y == global.oldest_player.y) {
		x = lerp(x, target_x, 0.015) //+ 30 * sin(current_time * 0.0005);
		y = lerp(y, target_y, 0.015) //+ 30 * cos(current_time * 0.0005);
		
		if (instance_exists(oShadow)) {
			x = lerp(x, target_x, 0.015) //+ 30 * sin(current_time * 0.0005);
			y = lerp(y, target_y, 0.015) //+ 30 * cos(current_time * 0.0005);
		}
	
		if (global.oldest_player.idle_time > 1900) {
			angle += 0.2;	
		}
	} else {
		x = lerp(x, target_x, 0.025) //+ 30 * sin(current_time * 0.0005);
		y = lerp(y, target_y, 0.025) //+ 30 * cos(current_time * 0.0005);
	
	}

} else {
	target_x = x;
	target_y = y;
	x = lerp(x, target_x, 0.025) //+ 30 * sin(current_time * 0.0005);
	y = lerp(y, target_y, 0.025) //+ 30 * cos(current_time * 0.0005);
}


if (target_x == oPlayer.x and oPlayer.camera_x_axis == 0) {
	if (oPlayer.move_speed > 0) {
		var targ_angle = -round((90-oPlayer.move_direction)/45) * 45;
		angle = angle_lerp(angle, targ_angle, 0.00065);
		
		image_zscale += dsin(oPlayer.move_direction) * 0.001;
	} else {
		var targ_angle = round((angle)/45) * 45 + sin(current_time * 0.00001) * 7 * !pixel_perfect;
		angle = angle_lerp(angle, targ_angle, 0.0015);

	}
}

image_zscale = clamp(image_zscale, zscale_min, zscale_max);


// squash the view, making the projection more isometric
//	this works by making the larger view_height get crushed down into the same application_surface size
//	then reposition view to keep it moving around the same point
	
//stacking_fidelity = round(image_zscale); //more dynamic amount works better for larger range of Zs
stacking_fidelity = 2.0; //otherwise you can use a constant
z_step = 1/stacking_fidelity;
stretch_factor = power(image_zscale/zscale_min, 1.25); 

var new_width = DEFAULT_WIDTH  ;
var new_height= DEFAULT_HEIGHT * image_zscale;

new_x = x - new_width/2;
new_y = y - new_height/2;

screenshake = clamp(screenshake, 0, 1)
if (screenshake > 0) {
	var screenshake_amount = screenshake_intensity * power(screenshake, 1.5) + screenshake * 2;
	new_x += random_range(screenshake_amount/2, screenshake_amount) * choose(-1, 1);
	new_y += random_range(screenshake_amount/2, screenshake_amount) * choose(-1, 1);
	
	if (global.gamepad_connected) {
		gamepad_set_vibration(global.gamepad_slot, screenshake, screenshake)	
	}
		
	screenshake -= screenshake_decrease
} else {
	if (global.gamepad_connected) {
		gamepad_set_vibration(global.gamepad_slot, 0, 0)	
	}
}

// set new camera values
camera_set_view_pos(view_camera[0], new_x, new_y);
camera_set_view_size(view_camera[0], new_width, new_height);
camera_set_view_angle(view_camera[0], angle);

#region pixel perfect
if (last_pixel_perfect != pixel_perfect) {
	surface_resize(application_surface, DEFAULT_WIDTH * pixel_perfect, DEFAULT_HEIGHT * pixel_perfect);

	
	last_pixel_perfect = pixel_perfect;
}

if (check_p(vk_alt) and LEVEL_EDITOR_ENABLED) pixel_perfect++;
if (pixel_perfect > scale) pixel_perfect = 1;

#endregion