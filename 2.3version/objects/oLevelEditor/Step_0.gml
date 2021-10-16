/// @description

if (check_p(vk_tab)) {
	editor_open = !editor_open;
	//show_debug_overlay(editor_open);

}

if (editor_open) {
	if (check_p(ord("G"))) {
		grid_enabled = !grid_enabled;
		play_sound(sndPlayerPickup, 0, false, 2.5, 0.2, sound_effect_volume);
	}
	
	if (check(vk_c)) {
		oCamera.angle = 0;	
	}
	
	
	if (check_p(vk_lshift)) {
		brush_mode = !brush_mode;
		cursor_changed = 30;
		//selected_object = noone;
	}
	
	#region clicking menu stuff
	var gui_x = device_mouse_x_to_gui(0);
	var gui_y = device_mouse_y_to_gui(0);
	
	draw_set_font(sFontEditor);
	if (selected_object == noone) {
		preview_list_position += (mouse_wheel_down() - mouse_wheel_up());
		preview_list_position = clamp(preview_list_position, 0, ds_list_size(preview_list[area]) - preview_list_max_items);
		
	#region right side menu
		var last_preview_selected = preview_selected;
		preview_selected = noone
		for(var i = 0; i < ds_list_size(preview_list[area]); i++) {
			if (point_in_rectangle(gui_x, gui_y, right_side_x + 4, text_y + preview_height + (string_height("M")) * i + 12, right_side_x + 4 + right_side_width, text_y + preview_height + (string_height("M")) * (i +1) + 12)) {
				preview_selected = ds_list_find_value(preview_list[area], i + preview_list_position);
				if (is_undefined(preview_selected)) preview_selected = noone;
				//log("selected");
				break;
			}
				
		}
		
		if (last_preview_selected != preview_selected) {
			preview_angle = 280;	
		} else {
			preview_angle = angle_lerp(preview_angle, 0, 0.1);
		}
		
		if (mouse_check_button_pressed(mb_left) and preview_selected != noone) {
			selected_object = instance_create_layer(mouse_x, mouse_y, "Instances", preview_selected);
			
			play_sound(sndBoneExplosion, 0, false, 2.5, 0.2, sound_effect_volume);
		}
	#endregion
		
		#region save
		if (point_in_rectangle(gui_x, gui_y, 40-20, 0, 40+20, 25)) {
			if (mouse_check_button_pressed(mb_left)) {
				play_sound(sndBoneExplosion, 0, false, 1.5, 0.2, sound_effect_volume);
				save_room(get_string("Enter File to Save To.", "test.room"));
			}
			
			text_colors[? "save"] = text_hover_color;
		} else {
			text_colors[? "save"] = c_white;	
		}
		#endregion
		
		#region load
		if (point_in_rectangle(gui_x, gui_y, 100-20, 0, 100+20, 25)) {
			if (mouse_check_button_pressed(mb_left)) {
				play_sound(sndBoneLaunch, 0, false, 1.0, 0.2, sound_effect_volume);
				load_room(  get_string("Enter File to Load From.", "test.room"));
			}
			
			text_colors[? "load"] = text_hover_color;
		} else {
			text_colors[? "load"] = c_white;	
		}
		#endregion
		
		#region grid
		if (point_in_rectangle(gui_x, gui_y, 160-20, 0, 160+20, 25)) {
			if (mouse_check_button_pressed(mb_left)) {
				play_sound(sndPlayerPickup, 0, false, 2.5, 0.2, sound_effect_volume);
				grid_enabled = !grid_enabled;
			}		
			
			text_colors[? "grid"] = text_hover_color;
		} else {
			text_colors[? "grid"] = c_white;	
		}
		#endregion
		
		
	}
	#endregion	
	
	#region moving + rotating world objects
	if (mouse_check_button_pressed(mb_left) and !point_in_rectangle(gui_x,gui_y, 0, 0, right_side_x+right_side_width, 25) and !point_in_rectangle(gui_x,gui_y,right_side_x, 0, display_get_gui_width(), display_get_gui_height())) {		
		if (selected_object == noone) {
			ds_list_clear(place_list);
			var len = instance_position_list(mouse_x,mouse_y, pDepth, place_list, true);
			
			if (len == 0) {
				selected_object = noone;
			} else {
				selected_object = place_list[| 0];		
				
				if (selected_object.object_index == oFireParticle or selected_object.object_index == oDogParticle or selected_object.object_index == oDustParticle) selected_object = noone;
			}
			
			if (selected_object == noone) { //play different sounds based of whether they picked up the object
				play_sound(sndGrassFootstep, 0, false, 1.0, 0.2, sound_effect_volume);
			} else {
				play_sound(sndGrassFootstep, 0, false, 1.5, 0.2, sound_effect_volume);
			}
		} else {
			if (brush_mode) {
				var inst = instance_create_layer(selected_object.x, selected_object.y, selected_object.layer, selected_object.object_index) 
					inst.image_angle = selected_object.image_angle;
					inst.z = selected_object.z;	
	
				repeat(3)
					instance_create_layer(selected_object.x + irandom_range(-8, 8), selected_object.y + irandom_range(-8, 8), selected_object.layer, oDustParticle);
			} else { // drop the object if not brush mode
				selected_object.image_blend = c_white;
				
				repeat(3)
					instance_create_layer(selected_object.x + irandom_range(-8, 8), selected_object.y + irandom_range(-8, 8), selected_object.layer, oDustParticle);
				
				selected_object = noone;	

			}
				
			play_sound(sndGrassFootstep, 0, false, 2.0, 0.2, sound_effect_volume);
		}
	}
	
	if (mouse_check_button(mb_right) and selected_object != noone) {
		instance_destroy(selected_object);
		selected_object = noone;
		trashed_object = 30;
		
		play_sound(sndPlayerHurt, 0, false, 3.0, 0.2, sound_effect_volume);
	}
	
	if (selected_object != noone) {
		if (brush_mode) {
			selected_object.image_blend = c_teal;
		} else {
			selected_object.image_blend = c_lime;
		}
		selected_object.x = mouse_x;
		selected_object.y = mouse_y;
		
		if (check(vk_lcontrol)) {
			selected_object.image_xscale += (mouse_wheel_up() - mouse_wheel_down()) * 0.1;
			selected_object.image_yscale += (mouse_wheel_up() - mouse_wheel_down()) * 0.1;
			selected_object.image_zscale = selected_object.image_xscale;
		} else {
			selected_object.image_angle += (mouse_wheel_up() - mouse_wheel_down()) * 5;
		}
		selected_object.image_angle = angle_lerp(selected_object.image_angle, selected_object.image_angle , 1)
	}
	#endregion
	

}

if is_undefined(selected_object) or !instance_exists(selected_object) {
	selected_object = noone;	
}

if is_undefined(preview_selected) {
	preview_selected = noone;	
}