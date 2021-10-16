/// @description
if (state != shadow.vanished) {
	if (scale < 0.99 or state == shadow.defeated) {
		shader_set(shdWhiteShift);	
	}
	
	draw_billboarded_sprite(sprite_index, image_index, x, y, 0, image_xscale * scale ,image_yscale * scale, 0, c_white, 1.0)

	if (scale < 0.99 or state == shadow.defeated)  {
		shader_reset();
	}
}

//draw_text(x,y , string(hp));
