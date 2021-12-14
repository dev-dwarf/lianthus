/// @description
if global.last_room == connected_room[room] {
	locked = false;
	immune = true;
	
	oPlayer.x = x// + 4 * oCamera.x_step;
	oPlayer.y = y// + 4 * oCamera.y_step;
	
	if (instance_exists(collision_instance)) {
		instance_destroy(collision_instance);
	}
}