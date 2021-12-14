/// @description
exit;
if (ceil(image_index) >= image_number) {
	image_speed = 0;	
	if (!set) {
		oPlayer.state = player.walk;
		set = true;
	}
} else {
	oCamera.x = x;
	oCamera.y = y - 100;
}

draw_billboarded_sprite(sprite_index, image_index, x, y, 60, image_xscale , image_yscale, 0, c_white, 1.0)
