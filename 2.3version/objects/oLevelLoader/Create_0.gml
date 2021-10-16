/// @description
if LEVEL_EDITOR_ENABLED and global.last_room == noone {
	var rm = asset_get_index(get_string("Enter Room to go to:", "rShrine"));
	global.last_room = rm;
	room_goto(rm);
	//load_room(  get_string("Enter File to Load From.", "test.room"));
} else{
	if (global.last_room == noone) {
		room_goto(rLogoSplashScreen);
		global.last_room = rLogoSplashScreen;
	}
	load_room(file);	
	
	
	// set oldest player after room is loaded
	global.oldest_player = instance_find(oPlayer, 0);
}

index = 8;

if (global.dark[room]) {
	transition_sprite = sTransitionDark;	
} else {
	transition_sprite = sTransition;	
}