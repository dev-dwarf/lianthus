/// @description

wait = 10;

timer = 5.5 * 60;
time_stretch = 0.35;

image_speed = 0;

move_speed = 0;
move_speed_max = 2.0;


draw_direction_offset = 215;
move_direction = draw_direction_offset;
last_move_direction = 0;

mouse_has_moved = false;
previous_mouse_x = mouse_x;

move_vectors[0] = 0;
move_vectors[1] = 0;
played_step = false;	



freeze = 1.5 * 60;

angle_offsets[0] = 0;
angle_offsets[1] = 0;
angle_offsets[2] = 0;
angle_offsets[3] = 0;

palette_uniforms = ds_list_create();
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color0"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color1"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color2"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color3"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color4"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color5"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color6"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color7"));

notes = part_system_create();

note = part_type_create();
part_type_sprite(note, sNoisyParticles, false, false, true);
part_type_speed(note, 1.4, 1.5, -0.025, 0);
part_type_direction(note, 70, 110, 0, 2);
part_type_life(note, 45, 60);
part_type_size(note, 1.0, 1.25, -0.01, 0);