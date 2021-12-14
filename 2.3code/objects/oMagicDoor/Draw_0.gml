/// @description
draw_stacked_sprite_ext(sprite_index, x, y, 0, image_xscale, image_yscale, 1.0, image_angle, !locked * 0.2 + global.dark[room] * 0.4 + wobble, false);

if distance_to_object(oPlayer) < 140 and locked and get_data("keys", 0) > 0 {
	var height = 36;
	
	if distance_to_object(oPlayer) < 20 {
		height = 16 + distance_to_object(oPlayer);
	}
	
	draw_billboarded_sprite(sKeyIcon, oPlayer.image_index, x, y, height + 2 * dsin(oPlayer.image_index * 90), image_xscale* 0.5, image_yscale* 0.5, 0, image_blend, 1.0);
}
