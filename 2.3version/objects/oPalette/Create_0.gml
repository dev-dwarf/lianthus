/// @description
event_inherited();
if get_data("paletteGrabbed" + string(room), false) and !LEVEL_EDITOR_ENABLED {
	instance_destroy();	
}

showing_palette = get_data("unlocked_palettes", 0);
target_dir = noone;

// need 12 of dese, 10 in so far