/// @description
if (text_complete and room == rShrine) {
	radius =  5 * (150/(max(fade_time,1)))
	draw_set_color(make_color_rgb(255, 255, 247));
	draw_circle(oShrine.x - oCamera.x_step * 6, oShrine.y - oCamera.y_step * 6, radius, false);
	draw_set_color(c_white);
}