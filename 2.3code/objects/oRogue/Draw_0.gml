/// @description

if (!global.dark[room]) {
	if (room == rShrine and get_data("shadow_defeated", false) == false) {
	
		exit;	

	} else 
		if (room != rShrine and get_data("shadow_defeated", false)) {
			exit;
		} 
	
}


draw_billboarded_sprite(sprite_index, oPlayer.image_index, x, y, 0, image_xscale ,image_yscale, 0, c_white, 1.0)