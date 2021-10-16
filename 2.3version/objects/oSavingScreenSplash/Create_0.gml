/// @description
timer = 3.5 * 60;

text = get_text_by_index(70);

white = make_color_rgb(255, 255, 247);
purple = make_color_rgb(0, 77, 87);
black = make_color_rgb(10, 3, 13);

index = 8;

palette_uniforms = ds_list_create();
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color0"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color1"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color2"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color3"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color4"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color5"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color6"));
ds_list_add(palette_uniforms, shader_get_uniform(shdPaletteSwap, "color7"));

	play_sound(musLightWorldIntro, 0, false, 1.0, 0, music_volume);
