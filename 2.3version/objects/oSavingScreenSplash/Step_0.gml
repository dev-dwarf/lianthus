/// @description

var press;
if (global.gamepad_connected) {
	press = g_check_p(global.gamepad_slot, gp_face3) or g_check_p(global.gamepad_slot, gp_shoulderrb);
} else {
	press = mouse_check_button_pressed(mb_left) or check_p(vk_j);
}

press = press and !get_data("hover", false);

if (press or (timer--) <= 0) {
	audio_stop_sound(musLightWorldIntro);
	room_goto(rTitle);	
}