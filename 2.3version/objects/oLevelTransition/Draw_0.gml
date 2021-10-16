/// @description
if (LEVEL_EDITOR_ENABLED and oLevelEditor.editor_open) {
	if (target_room == noone) {
		target_room =  get_string("Enter name of room this gate leads to:", "rShrine");
		target_room = asset_get_index(target_room);
	}
	
	draw_self();	
}