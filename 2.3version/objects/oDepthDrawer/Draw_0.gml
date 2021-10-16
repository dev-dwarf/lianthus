/// @description
if (!ds_exists(depth_grid, ds_type_grid)) exit;

//if !(LEVEL_EDITOR_ENABLED and oLevelEditor.editor_open) {
//	shader_set(shdPassThrough); // set optimized shader
//}

// player death state code, overrides normal drawing
if global.oldest_player.state == player.dead and global.oldest_player.image_index > 1 {
	var c = make_color_rgb(10, 3, 13);
	var r = 300 //* min(2 * oPlayer.image_index/oPlayer.image_number, 1);
	draw_circle_color(oCamera.x, oCamera.y, r, c, c, false);
	//draw_rectangle_color(oCamera.x - r, oCamera.y - r, oCamera.x + r, oCamera.y + r, c, c, c, c, false);
	//with oPlayer {
	//	event_perform(ev_draw, 0);
	//}
	
	
	//if (floor(oPlayer.image_index) == oPlayer.image_number-1) {
	//	var x_off = DEFAULT_WIDTH * 1/3 * dcos(oCamera.angle);
	//	var y_off = DEFAULT_WIDTH * 1/3 * dsin(oCamera.angle);
	//	oCamera.x = lerp(oCamera.x, oPlayer.x + x_off, 0.05);
	//	oCamera.y = lerp(oCamera.y, oPlayer.y + y_off, 0.05);
	//}
	//exit;
}

for (var i = 0; i < ds_grid_height(depth_grid); i++) {
	var inst = depth_grid[# 0, i];
	
	if (is_undefined(inst) or !instance_exists(inst)) {
		//ds_grid_delete_row(depth_grid, i);
		continue;
	}
	
	#region draw culling
	if (inst.object_index != oFakeLeaves and 
		point_distance(oCamera.x, oCamera.y, inst.x, inst.y) > max(DEFAULT_HEIGHT * oCamera.image_zscale, DEFAULT_WIDTH)) {
		continue; // culling	
	}
	
	if (object_is_ancestor(inst, pPlant) or object_index == oSunflower or object_index == oSmallSunflower or object_index == oSkull or object_index == oPoppy) and 
		point_distance(oCamera.x, oCamera.y, inst.x, inst.y) > DEFAULT_HEIGHT * oCamera.image_zscale * 0.9 {
		continue; // culling	
	}
	#endregion
	
	if (global.oldest_player.state == player.dead and global.oldest_player.image_index > 1) and !(inst.object_index == oPlayer or inst.object_index == oCrow) {
		continue;
	}	
	
	with (inst) { // run the instance's draw event
		event_perform(ev_draw, 0);
	}
}

var inst = instance_find(oShadow, 0);
if (instance_exists(inst) and inst.state == shadow.defeated) {
	with inst {
		radius = 3 * (120/(max(fade_time,1)))
		draw_set_color(make_color_rgb(10, 3, 13));
		draw_circle(x - oCamera.x_step * 6 + irandom_range(-1, 1), y - oCamera.y_step * 6 + irandom_range(-1, 1), radius, false);
		draw_set_color(c_white);
	}
}

shader_reset();

//if !(LEVEL_EDITOR_ENABLED and oLevelEditor.editor_open) {
//	shader_reset();
//}