/// @description

if (wait-- > 0) exit;

if (freeze < 5) {
	if (image_xscale == 1) {
		image_speed = 1;
		play_sound(musNoisyBugIntro, 10, false, 1.0, 0.0, music_volume);
	}
	
	image_xscale = lerp(image_xscale, 0.5, 0.15);
	image_yscale = image_xscale;
	
	if (ceil(image_index) == 2) freeze = 0;
}

if (freeze-- > 0) exit;

var press;
if (global.gamepad_connected) {
	press = g_check_p(global.gamepad_slot, gp_face3) or g_check_p(global.gamepad_slot, gp_shoulderrb);
} else {
	press = mouse_check_button_pressed(mb_left) or check_p(vk_j);
}

press = press and !get_data("hover", false);

if (press or (timer--) <= 0) {
	audio_stop_sound(musNoisyBugIntro);
	room_goto(rSavingSplashScreen);	
}

if (floor(image_index) == 0) {
	image_speed = 0;
	image_index += 0.01;
} else {
	if (image_speed != 1) {
		image_xscale += 0.05;
		image_yscale += 0.05;
		play_sound(sndNoisyBugBlink, 0, false, 1.34, 0.0, sound_effect_volume);	
		image_speed = 1;	
	}
}

//log(string(image_speed));

mouse_has_moved = (mouse_x != previous_mouse_x) or mouse_has_moved;

previous_mouse_x = mouse_x;

move_speed = approach(move_speed, move_speed_max, 0.05);

if (global.gamepad_connected) {
	move_direction = angle_lerp(move_direction, point_direction(0,0,gamepad_axis_value(global.gamepad_slot, gp_axislh), gamepad_axis_value(global.gamepad_slot, gp_axislv)), 0.45);	
	
	move_vectors[0] = lerp(move_vectors[0], lengthdir_x(move_speed, move_direction), 0.15);
	move_vectors[1] = lerp(move_vectors[1], lengthdir_y(move_speed, move_direction), 0.15);
} else {
	move_direction = angle_lerp(move_direction, point_direction(x,y,mouse_x,mouse_y), 0.45);	
	
	if point_distance(x,y,mouse_x,mouse_y) > 3 {
		move_vectors[0] = lerp(move_vectors[0], lengthdir_x(move_speed, move_direction), 0.15);
		move_vectors[1] = lerp(move_vectors[1], lengthdir_y(move_speed, move_direction), 0.15);
	}
}

x += move_vectors[0];
y += move_vectors[1];

var dist = point_distance(xprevious, yprevious, x, y);
var mult = 1.75;
var amp = min(5, dist * mult) * cos(timer * time_stretch);
var r = 5;
if (dist > 1 and chance(40)) {
	part_particles_create(notes, x + irandom_range(-r, r), y + irandom_range(-r, r), note, 1)
	
}

if (abs(cos(timer * time_stretch)) > abs(cos((timer+1) * time_stretch))) {
	if (!played_step and dist > 1) {
		play_sound(sndNoisyBugStep, 0, false, 1.5, 0.1, 0.25 * sound_effect_volume);	
		played_step = true;
	}
} else {
	played_step = false;	
}



for (var i = 0; i < 4; i++) {
	angle_offsets[i] = amp * power(-1, i);	
}

last_move_direction = move_direction;
