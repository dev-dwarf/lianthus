/// @description

if (state == rogue.dying) exit;

if (state == rogue.appear) {
	draw_billboarded_sprite(sMagicCircle, image_index, x, y, 0, image_xscale ,image_yscale, 0, make_color_rgb(255, 0, 89), 1.0)	
}
	
draw_billboarded_sprite(sprite_index, image_index, x, y, 0, image_xscale ,image_yscale, 0, c_white, 1.0)
