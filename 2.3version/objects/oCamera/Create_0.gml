/// @description
angle = 0;

image_zscale = 1.25;
zscale_min = 1.25;
zscale_max = 2.25;

stacking_fidelity = 1;
stretch_factor = power(image_zscale/zscale_min, 1.25); 

target_x = room_width/2;
target_y = room_height/2;

x_step = dcos(90 + angle);
y_step = dsin(90 + angle);
z_step = 1/stacking_fidelity;

#region setup camera
if (view_camera[0] > 0) {
	view_enabled = true;
	view_visible[0] = true;
	view_camera[0] = camera_create_view(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT, angle, -1, -1, -1, -1, -1);
}
#endregion

#region resize window

scale = 3;
//scale = floor(display_get_height()/DEFAULT_HEIGHT); //3
window_x = (display_get_width()  - DEFAULT_WIDTH  * scale) / 2; //get centered coords
window_y = (display_get_height() - DEFAULT_HEIGHT * scale) / 2;

surface_resize(application_surface,DEFAULT_WIDTH*pixel_perfect,DEFAULT_HEIGHT*pixel_perfect);
display_set_gui_size(DEFAULT_WIDTH*scale,DEFAULT_HEIGHT*scale);

global.gui_scale = scale;
if (!global.set_window) {
	window_set_rectangle(window_x, window_y, DEFAULT_WIDTH*scale,DEFAULT_HEIGHT*scale); // centers window
	global.set_window = true;
}

last_pixel_perfect = pixel_perfect;
#endregion

#region setup draw pipeline for maximum performance
//gpu_set_blendenable(false);
//if !LEVEL_EDITOR_ENABLED {
//	gpu_set_alphatestenable(true);
//	gpu_set_alphatestref(128);
	
//	gpu_set_colorwriteenable(true, true, true, false);

//}
#endregion

#region screenshake
screenshake = 0;
screenshake_intensity = 6;
screenshake_decrease = 0.017;

#endregion

last_focused = window_has_focus();

//show_debug_overlay(!global.hide_gui and LEVEL_EDITOR_ENABLED)
//randomize();


//room_started = 220;

draw_set_halign(fa_center);
draw_set_valign(fa_center);

instance_create_layer( x, y, layer, oAmbiencePlayer);

palette_uniforms = ds_list_create();

ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color0"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color1"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color2"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color3"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color4"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color5"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color6"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color7"));

//alarm[5] = 80;
