/// @description

// Inherit the parent event
event_inherited();

if get_data("keyGrabbed" + string(room), false) and !LEVEL_EDITOR_ENABLED {
	instance_destroy();	
}