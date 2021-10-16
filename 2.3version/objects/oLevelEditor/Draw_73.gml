/// @description


if (editor_open) {	
	if (brush_mode) {
		var frame = 0;
		var sprite = sCursorBrush

		if (selected_object != noone) frame = 2;
		if (mouse_check_button(mb_left)) frame = 1;	
	} else {
		var frame = 0;
		var sprite = sCursorHand

		if (mouse_check_button(mb_left)) frame = 1;
		if (selected_object != noone) frame = 2;
	
	}
	
	draw_billboarded_sprite(sprite, frame, round(mouse_x), round(mouse_y), 0, 1, 1, 0, c_white, 1);	
	
	if (cursor_changed) {
		if (sprite == sCursorHand) {
			draw_text_transformed(round(mouse_x) - lengthdir_x(8, oCamera.angle), round(mouse_y) - lengthdir_y(8, oCamera.angle), "Edit", 0.75, 0.75, -oCamera.angle);
				
		} else {
			draw_text_transformed(round(mouse_x) - lengthdir_x(8, oCamera.angle), round(mouse_y) - lengthdir_y(8, oCamera.angle), "Place", 0.75, 0.75, -oCamera.angle);
			
		}
	
		cursor_changed--;
	} 
	
	if (trashed_object) {
		draw_text_transformed(round(mouse_x) + lengthdir_x(8, oCamera.angle), round(mouse_y) + lengthdir_y(8, oCamera.angle), "Trashed", 0.75, 0.75, -oCamera.angle);
		
		trashed_object--;
	}
}