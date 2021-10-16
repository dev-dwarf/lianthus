///@desc save_room
///@param file
function load_room(argument0) {
	var filename = argument0;

	if (!file_exists(working_directory + filename)) {
		file_text_close(file_text_open_write(working_directory + filename));
		return;
	}

	var file = file_text_open_read(working_directory + filename);

	var obj, xx, yy, angle, xscale, yscale, sprite, str;

	instance_destroy(pDepth);
	//instance_destroy(oCamera);

	while !file_text_eof(file) {
		str = split_string(file_text_readln(file));
	
		obj		= asset_get_index(str[| 0]);
		xx		= real(str[| 1]);
		yy		= real(str[| 2]);
		angle	= real(str[| 3]);
		xscale  = real(str[| 4]);
		yscale  = real(str[| 5]);
		sprite	= real(str[| 6]);
	
		if (asset_get_index(obj) == pDepth) continue;
	
	
			
	
		with instance_create_layer(xx, yy, "Instances", obj) {
			image_angle = angle;	
			image_xscale = xscale;
			image_yscale = yscale;
		
			if (object_index == oLevelTransition) {
				target_room = real(str[| 7]);
			}
		}
		//log("Created: " + object_get_name(obj));
	}

	if (!instance_exists(oPlayer)) instance_create_layer(0, 0, layer, oPlayer);
	//instance_create_layer(oPlayer.x, oPlayer.y, oPlayer.layer, oCamera);
	file_text_close(file);


}
