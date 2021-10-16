///@desc save_room
///@param file
function save_room(argument0) {
	var filename = argument0;

	if (file_exists(working_directory + filename)) {
		file_delete(working_directory + filename);	
	}

	var file = file_text_open_write(working_directory + filename);
	var str = "";

	instance_destroy(oDogParticle);
	instance_destroy(oFireParticle);
	instance_destroy(oDustParticle);


	with pDepth {
		if !(object_index == oShrineColumn and room == rShrine) {
			str =	object_get_name(object_index)	+ " " + //encode object info as string
					string(x)				+ " " +
					string(y)				+ " " +
					string(image_angle)		+ " " +
					string(image_xscale)    + " " +
					string(image_yscale)    + " " +
					string(sprite_index);
				
			if (object_index == oLevelTransition) {
				str += " " + string(target_room);	
			}
			
	
			//log(string(object_get_name(object_index)) + " " + str);
			file_text_write_string(file, str);
			file_text_writeln(file); // go to next line
		}
	}

	file_text_close(file);


}
