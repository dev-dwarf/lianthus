/// @description
if (state == shadow.defeated) {
	radius = 3 * (120/(max(fade_time,1)))
	draw_set_color(make_color_rgb(10, 3, 13));
	draw_circle(x - oCamera.x_step * 6 + irandom_range(-1, 1), y - oCamera.y_step * 6 + irandom_range(-1, 1), radius, false);
	draw_set_color(c_white);
}