/// @description
if !(LEVEL_EDITOR_ENABLED and oLevelEditor.editor_open) {
	if (point_distance(x,y, oPlayer.x, oPlayer.y) < sprite_width * 0.5) {
		transition_triggered = !immune;
	} else {
		immune = false;	
	}
}