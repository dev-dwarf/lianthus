/// @description

if (global.gamepad_connected) {
	if (check_p(vk_anykey)) {
		global.gamepad_connected = false;
	}
} else {
	if (gamepad_anykey(global.gamepad_slot)) {
		global.gamepad_connected = true;
	}
}