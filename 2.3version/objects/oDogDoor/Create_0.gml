/// @description

// Inherit the parent event
event_inherited();

if get_data("dog_defeated", false) and !LEVEL_EDITOR_ENABLED {
	instance_destroy();	
}

sound_max_range = 120;
sound_close_range = 10;
sound_id = noone;