/// @description
//draw_set_font(sFont1);

if (editor_open) {
	draw_set_font(sFontEditor);

	draw_set_color(c_black);
	draw_set_alpha(0.25);
	draw_rectangle(0, 0, right_side_x, 25, false);
	draw_rectangle(right_side_x, 0, display_get_gui_width(), display_get_gui_height(), false);
	
	draw_set_color(c_gray);
	draw_rectangle(right_side_x+4, text_y + 8, display_get_gui_width()-4, text_y + 8 + preview_height, false);
	
	draw_set_color(c_white);
	draw_set_alpha(1.0);	
	
	draw_text_color(40,  text_y, "SAVE", text_colors[? "save"], text_colors[? "save"], text_colors[? "save"], text_colors[? "save"], 1.0);
	draw_text_color(100, text_y, "LOAD", text_colors[? "load"], text_colors[? "load"], text_colors[? "load"], text_colors[? "load"], 1.0);
	draw_text_color(160, text_y, "GRID", text_colors[? "grid"], text_colors[? "grid"], text_colors[? "grid"], text_colors[? "grid"], 1.0);
	draw_text(right_side_x/2, text_y, "WOBS 0.0.2");
	
	draw_text(right_side_x + right_side_width/2, text_y, "SELECT");
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	for(var i = 0; i < min(ds_list_size(preview_list[area]), preview_list_max_items); i++) {
		var col = c_white;
		
		if (preview_selected == ds_list_find_value(preview_list[area], i + floor(preview_list_position))) {
			col = text_hover_color;	
		}
		
		draw_text_color(right_side_x + 4, text_y + preview_height + (string_height("M")) * i + 12, object_get_name(ds_list_find_value(preview_list[area], i + floor(preview_list_position))), col, col, col, col, 1.0);
	}
	
	if preview_selected != noone {
		var temp_angle = oCamera.angle;
		oCamera.angle = 0;
		draw_stacked_sprite_ext(object_get_sprite(preview_selected), right_side_x + right_side_width/2, preview_height*3/4 + text_y, 0, 1.0, 1.0, 1.0, preview_angle);
		
		oCamera.angle = temp_angle;
	}
	
	draw_set_halign(fa_middle);
	draw_set_valign(fa_center);
	
	if (selected_object) {
		draw_text(right_side_x-160, text_y, "X:" + string(round(selected_object.x)));
		draw_text(right_side_x-100, text_y, "Y:" + string(round(selected_object.y)));
		draw_text(right_side_x-40,  text_y, "A:" + string(round(selected_object.image_angle)));	
		
	}
}