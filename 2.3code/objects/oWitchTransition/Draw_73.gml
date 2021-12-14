/// @description
radius = lerp(radius, 0, 0.018);	
draw_set_color(make_color_rgb(10, 3, 13));
draw_set_circle_precision(32);
draw_circle(oShrine.x - oCamera.x_step * 6 + irandom_range(-1,1), oShrine.y - oCamera.y_step * 6 + irandom_range(-1,1), radius, false);
draw_set_color(c_white);

oCamera.screenshake = 0.125;

if (radius < 1) instance_destroy();