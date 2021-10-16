function MACROS() {
	gml_pragma("global", "MACROS()")

#macro DEFAULT_WIDTH 256	
#macro DEFAULT_HEIGHT 144

#macro vk_a ord("A")
#macro vk_s ord("S")
#macro vk_d ord("D")
#macro vk_f ord("F")
#macro vk_w ord("W")
#macro vk_r ord("R")
#macro vk_z ord("Z")
#macro vk_x ord("X")
#macro vk_c ord("C")
#macro vk_v ord("V")
#macro vk_e ord("E")
#macro vk_q ord("Q")
#macro vk_j ord("J")
#macro vk_k ord("K")
#macro vk_l ord("L")
#macro vk_colon 186

#macro check keyboard_check
#macro check_p keyboard_check_pressed
#macro check_r keyboard_check_released

#macro g_check gamepad_button_check
#macro g_check_p gamepad_button_check_pressed
#macro g_check_r gamepad_button_check_released

#macro log show_debug_message
#macro show show_message

#macro NEWLINE chr(10)

#macro LEVEL_EDITOR_ENABLED false

#macro SAVEFILE "save.ini"

	globalvar pixel_perfect;


	global.set_window = false;
	global.last_room = noone;

	globalvar sound_effect_volume;
	globalvar music_volume;
	globalvar fullscreen;


	random_set_seed(505)

	global.dark[rShrine]	= false;
	global.dark[rForest]	= false;
	global.dark[rField]		= false;
	global.dark[rWitch]		= false; 
	global.dark[rFlats]		= false; 
	global.dark[rEast]		= false; 
	global.dark[rPath]		= false;
	global.dark[rNorth]		= false;
	global.dark[rEnd]		= false;

	global.dark[rShrineDark]= true;
	global.dark[rWitchDark]	= true;
	global.dark[rFieldDark]	= true;
	global.dark[rForestDark]= true;
	global.dark[rDogDark]	= true;
	global.dark[rFlatsDark]	= true;
	global.dark[rEastDark]	= true;
	global.dark[rPathDark]	= true;
	global.dark[rNorthDark]	= true;
	global.dark[rEndDark]	= true;

	global.dark[rTitle]		= false;


	global.gamepad_connected = false;
	global.gamepad_slot = 0;
	global.gamepad_is_xbox = true;

	global.text_grid = load_csv("text.csv");

	//if (LEVEL_EDITOR_ENABLED)
		//file_delete(SAVEFILE);
	
	if (file_exists(SAVEFILE)) {
		global.save_data = ds_map_secure_load(SAVEFILE);	

	} else {
		global.save_data = ds_map_create();
		global.save_data[? "throw"]		= false;
		global.save_data[? "dash"]		= false;
		global.save_data[? "charge"]	= false;
		global.save_data[? "clone"]		= false;
	
		global.save_data[? "flowers"]	= 0;
		global.save_data[? "keys"]		= 0;
		global.save_data[? "active_columns"] = 0;
		global.save_data[? "unlocked_palettes"] = 0;
		global.save_data[? "hover"] = !LEVEL_EDITOR_ENABLED;
		global.save_data[? "sound_effect_volume"] = 0.6;
		global.save_data[? "music_volume"] = 0.6;
		//	global.save_data[? "music_volume"] = 0.0;

		global.save_data[? "pixel_perfect"] = 2;
		global.save_data[? "palette"] = 0;
		global.save_data[? "fullscreen"] = false;
		global.save_data[? "hide_gui"] = false;
	//		global.save_data[? "hide_gui"] = true;

	//		global.save_data[? "shadow_defeated"] = true;

	//	global.save_data[? "compass_unlocked"] = LEVEL_EDITOR_ENABLED;
			global.save_data[? "compass_unlocked"] = false;

	
		switch os_get_language() {
			case "en": global.save_data[? "language"] = 1; break;
			case "es": global.save_data[? "language"] = 2; break;
			case "ru": global.save_data[? "language"] = 3; break;
			case "pt": global.save_data[? "language"] = 4; break;
			case "fr": global.save_data[? "language"] = 5; break;
			case "de": global.save_data[? "language"] = 6; break;
			case "sv": global.save_data[? "language"] = 7; break;


			default:
			global.save_data[? "language"] = 1; // 1 for english
		}
	
		ds_map_secure_save(global.save_data, SAVEFILE);
	}

	global.max_language = 8;

	sound_effect_volume	= global.save_data[? "sound_effect_volume"];
	music_volume		= global.save_data[? "music_volume"];
	pixel_perfect		= global.save_data[? "pixel_perfect"];
	fullscreen			= global.save_data[? "fullscreen"];

	global.hide_gui = get_data( "hide_gui", false);

	//show(get_text_by_index(2))

	global.music_index	= noone;
	global.music_id		= noone;

	global.palette = get_data("palette", 0);
	global.palettes = ds_list_create();
	global.text_language = global.save_data[? "language"];

	global.oldest_player = noone;
	global.recently_saved = 0;

	// set screen 
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

	window_set_fullscreen(fullscreen);


#region vintage
	var vintage = ds_grid_create(8, 3);

	vintage[# 0, 0] = 42;
	vintage[# 0, 1] = 35;
	vintage[# 0, 2] = 73;

	vintage[# 1, 0] = 50;
	vintage[# 1, 1] = 83;
	vintage[# 1, 2] = 95;

	vintage[# 2, 0] = 130;
	vintage[# 2, 1] = 91;
	vintage[# 2, 2] = 49;

	vintage[# 3, 0] = 240;
	vintage[# 3, 1] = 189;
	vintage[# 3, 2] = 119;

	vintage[# 4, 0] = 255;
	vintage[# 4, 1] = 249;
	vintage[# 4, 2] = 228;

	vintage[# 5, 0] = 125;
	vintage[# 5, 1] = 56;
	vintage[# 5, 2] = 64;

	vintage[# 6, 0] = 13;
	vintage[# 6, 1] = 8;
	vintage[# 6, 2] = 13;

	vintage[# 7, 0] = 197;
	vintage[# 7, 1] = 145;
	vintage[# 7, 2] = 84;

	ds_list_add(global.palettes, vintage);
#endregion

#region autumn
	var autumn = ds_grid_create(8, 3);

	autumn[# 0, 0] = 38;
	autumn[# 0, 1] = 33;
	autumn[# 0, 2] = 68;

	autumn[# 1, 0] = 95;
	autumn[# 1, 1] = 67;
	autumn[# 1, 2] = 81;

	autumn[# 2, 0] = 158;
	autumn[# 2, 1] = 91;
	autumn[# 2, 2] = 71;

	autumn[# 3, 0] = 244;
	autumn[# 3, 1] = 205;
	autumn[# 3, 2] = 114;

	autumn[# 4, 0] = 255;
	autumn[# 4, 1] = 255;
	autumn[# 4, 2] = 255;

	autumn[# 5, 0] = 220;
	autumn[# 5, 1] = 57;
	autumn[# 5, 2] = 45;

	autumn[# 6, 0] = 0;
	autumn[# 6, 1] = 0;
	autumn[# 6, 2] = 0;

	autumn[# 7, 0] = 137;
	autumn[# 7, 1] = 137;
	autumn[# 7, 2] = 137;

	ds_list_add(global.palettes, autumn);
#endregion

#region dawn
	var dawn = ds_grid_create(8, 3);

	dawn[# 0, 0] =  34;
	dawn[# 0, 1] =  32;
	dawn[# 0, 2] =  52;

	dawn[# 1, 0] = 63;
	dawn[# 1, 1] = 63;
	dawn[# 1, 2] = 116;

	dawn[# 2, 0] = 102;
	dawn[# 2, 1] = 57;
	dawn[# 2, 2] = 49;

	dawn[# 3, 0] = 99;
	dawn[# 3, 1] = 155;
	dawn[# 3, 2] = 255;

	dawn[# 4, 0] = 238;	
	dawn[# 4, 1] = 195;	
	dawn[# 4, 2] = 154;	

	dawn[# 5, 0] = 233;
	dawn[# 5, 1] = 113;
	dawn[# 5, 2] = 38;

	dawn[# 6, 0] = 69;	
	dawn[# 6, 1] = 40;	
	dawn[# 6, 2] = 60;	

	dawn[# 7, 0] = 143;
	dawn[# 7, 1] = 86;
	dawn[# 7, 2] = 59;

	ds_list_add(global.palettes, dawn);
#endregion		

#region lemongrab
	var lemongrab = ds_grid_create(8, 3);

	lemongrab[# 0, 0] = 112;
	lemongrab[# 0, 1] = 84;
	lemongrab[# 0, 2] = 13;
	lemongrab[# 1, 0] = 206;
	lemongrab[# 1, 1] = 175;
	lemongrab[# 1, 2] = 9;
	lemongrab[# 2, 0] = 171;
	lemongrab[# 2, 1] = 163;
	lemongrab[# 2, 2] = 51;
	lemongrab[# 3, 0] = 255;
	lemongrab[# 3, 1] = 255;
	lemongrab[# 3, 2] = 58;
	lemongrab[# 4, 0] = 255;
	lemongrab[# 4, 1] = 255;
	lemongrab[# 4, 2] = 170;
	lemongrab[# 5, 0] = 255;
	lemongrab[# 5, 1] = 107;
	lemongrab[# 5, 2] = 0;
	lemongrab[# 6, 0] = 93;
	lemongrab[# 6, 1] = 64;
	lemongrab[# 6, 2] = 2;
	lemongrab[# 7, 0] = 190;
	lemongrab[# 7, 1] = 180;
	lemongrab[# 7, 2] = 88;

	ds_list_add(global.palettes, lemongrab);
#endregion

#region witching
	var witching = ds_grid_create(8, 3);

	witching[# 0, 0] = 94;
	witching[# 0, 1] = 32;
	witching[# 0, 2] = 82;
	witching[# 1, 0] = 177;
	witching[# 1, 1] = 51;
	witching[# 1, 2] = 83;
	witching[# 2, 0] = 65;
	witching[# 2, 1] = 46;
	witching[# 2, 2] = 55;
	witching[# 3, 0] = 219;
	witching[# 3, 1] = 96;
	witching[# 3, 2] = 76;
	witching[# 4, 0] = 246;
	witching[# 4, 1] = 219;
	witching[# 4, 2] = 186;
	witching[# 5, 0] = 116;
	witching[# 5, 1] = 201;
	witching[# 5, 2] = 158;
	witching[# 6, 0] = 39;
	witching[# 6, 1] = 24;
	witching[# 6, 2] = 84;
	witching[# 7, 0] = 121;
	witching[# 7, 1] = 115;
	witching[# 7, 2] = 102;

	ds_list_add(global.palettes, witching);
#endregion

#region vivid
	var vivid = ds_grid_create(8, 3);

	vivid[# 0, 0] = 27;
	vivid[# 0, 1] = 38;
	vivid[# 0, 2] = 50;

	vivid[# 1, 0] = 0;
	vivid[# 1, 1] = 87;
	vivid[# 1, 2] = 132;

	vivid[# 2, 0] = 150;
	vivid[# 2, 1] = 83;
	vivid[# 2, 2] = 29;

	vivid[# 3, 0] = 247;
	vivid[# 3, 1] = 226;
	vivid[# 3, 2] = 107;

	vivid[# 4, 0] = 255;
	vivid[# 4, 1] = 255;
	vivid[# 4, 2] = 255;

	vivid[# 5, 0] = 190;
	vivid[# 5, 1] = 38;
	vivid[# 5, 2] = 51;

	vivid[# 6, 0] = 0;
	vivid[# 6, 1] = 0;
	vivid[# 6, 2] = 0;

	vivid[# 7, 0] = 121;
	vivid[# 7, 1] = 115;
	vivid[# 7, 2] = 102;

	ds_list_add(global.palettes, vivid);
#endregion

#region forest
	var forest = ds_grid_create(8, 3);

	forest[# 0, 0] = 27;
	forest[# 0, 1] = 30;
	forest[# 0, 2] = 41;

	forest[# 1, 0] = 8;
	forest[# 1, 1] = 74;
	forest[# 1, 2] = 60;

	forest[# 2, 0] = 115;
	forest[# 2, 1] = 97;
	forest[# 2, 2] = 80;

	forest[# 3, 0] = 241;
	forest[# 3, 1] = 206;
	forest[# 3, 2] = 74;

	forest[# 4, 0] = 203;
	forest[# 4, 1] = 232;
	forest[# 4, 2] = 247;

	forest[# 5, 0] = 162;
	forest[# 5, 1] = 50;
	forest[# 5, 2] = 78;

	forest[# 6, 0] = 0;
	forest[# 6, 1] = 0;
	forest[# 6, 2] = 0;

	forest[# 7, 0] = 119;
	forest[# 7, 1] = 120;
	forest[# 7, 2] = 91;

	ds_list_add(global.palettes, forest);
#endregion					

#region coppertone
	var coppertone = ds_grid_create(8, 3);

	coppertone[# 0, 0] = 13;
	coppertone[# 0, 1] = 142;
	coppertone[# 0, 2] = 222;

	coppertone[# 1, 0] = 166;
	coppertone[# 1, 1] = 230;
	coppertone[# 1, 2] = 237;

	coppertone[# 2, 0] = 242;
	coppertone[# 2, 1] = 126;
	coppertone[# 2, 2] = 17;

	coppertone[# 3, 0] = 255;
	coppertone[# 3, 1] = 186;
	coppertone[# 3, 2] = 48;

	coppertone[# 4, 0] = 255;
	coppertone[# 4, 1] = 243;
	coppertone[# 4, 2] = 194;

	coppertone[# 5, 0] = 230;
	coppertone[# 5, 1] = 138;
	coppertone[# 5, 2] = 0;

	coppertone[# 6, 0] = 26;
	coppertone[# 6, 1] = 46;
	coppertone[# 6, 2] = 161;

	coppertone[# 7, 0] = 145;
	coppertone[# 7, 1] = 138;
	coppertone[# 7, 2] = 109;

	ds_list_add(global.palettes, coppertone);
#endregion		

#region candycorn
	var candycorn = ds_grid_create(8, 3);

	candycorn[# 0, 0] = 52;
	candycorn[# 0, 1] = 12;
	candycorn[# 0, 2] = 69;
	candycorn[# 1, 0] = 255;
	candycorn[# 1, 1] = 89;
	candycorn[# 1, 2] = 0;
	candycorn[# 2, 0] = 65;
	candycorn[# 2, 1] = 46;
	candycorn[# 2, 2] = 55;
	candycorn[# 3, 0] = 242;
	candycorn[# 3, 1] = 180;
	candycorn[# 3, 2] = 35;
	candycorn[# 4, 0] = 242;
	candycorn[# 4, 1] = 216;
	candycorn[# 4, 2] = 156;
	candycorn[# 5, 0] = 255;
	candycorn[# 5, 1] = 89;
	candycorn[# 5, 2] = 0;
	candycorn[# 6, 0] = 10;
	candycorn[# 6, 1] = 3;
	candycorn[# 6, 2] = 13;
	candycorn[# 7, 0] = 121;
	candycorn[# 7, 1] = 115;
	candycorn[# 7, 2] = 102;

	ds_list_add(global.palettes, candycorn);

#endregion

#region sepia
	var sepia = ds_grid_create(8, 3);

	sepia[# 0, 0] = 15;
	sepia[# 0, 1] = 42;
	sepia[# 0, 2] = 63;
	sepia[# 1, 0] = 32;
	sepia[# 1, 1] = 57;
	sepia[# 1, 2] = 79;
	sepia[# 2, 0] = 115;
	sepia[# 2, 1] = 97;
	sepia[# 2, 2] = 80;
	sepia[# 3, 0] = 195;
	sepia[# 3, 1] = 163;
	sepia[# 3, 2] = 138;
	sepia[# 4, 0] = 246;
	sepia[# 4, 1] = 214;
	sepia[# 4, 2] = 189;
	sepia[# 5, 0] = 129;
	sepia[# 5, 1] = 98;
	sepia[# 5, 2] = 113;
	sepia[# 6, 0] = 8;
	sepia[# 6, 1] = 20;
	sepia[# 6, 2] = 30;
	sepia[# 7, 0] = 78;
	sepia[# 7, 1] = 73;
	sepia[# 7, 2] = 95;

	ds_list_add(global.palettes, sepia);
#endregion					

#region dos
	var dos = ds_grid_create(8, 3);

	dos[# 0, 0] = 0;
	dos[# 0, 1] = 0;
	dos[# 0, 2] = 130;
	dos[# 1, 0] = 0;
	dos[# 1, 1] = 130;
	dos[# 1, 2] = 0;
	dos[# 2, 0] = 130;
	dos[# 2, 1] = 130;
	dos[# 2, 2] = 130;
	dos[# 3, 0] = 255;
	dos[# 3, 1] = 255;
	dos[# 3, 2] = 0;
	dos[# 4, 0] = 255;
	dos[# 4, 1] = 255;
	dos[# 4, 2] = 255;
	dos[# 5, 0] = 255;
	dos[# 5, 1] = 0;
	dos[# 5, 2] = 0;
	dos[# 6, 0] = 0;
	dos[# 6, 1] = 0;
	dos[# 6, 2] = 0;
	dos[# 7, 0] = 195;
	dos[# 7, 1] = 195;
	dos[# 7, 2] = 195;

	ds_list_add(global.palettes, dos);
#endregion					

#region roseblight
	var roseblight = ds_grid_create(8, 3);

	roseblight[# 0, 0] = 72;
	roseblight[# 0, 1] = 61;
	roseblight[# 0, 2] = 56;
	roseblight[# 1, 0] = 172;
	roseblight[# 1, 1] = 65;
	roseblight[# 1, 2] = 54;
	roseblight[# 2, 0] = 108;
	roseblight[# 2, 1] = 52;
	roseblight[# 2, 2] = 52;
	roseblight[# 3, 0] = 222;
	roseblight[# 3, 1] = 194;
	roseblight[# 3, 2] = 109;
	roseblight[# 4, 0] = 221;
	roseblight[# 4, 1] = 207;
	roseblight[# 4, 2] = 149;
	roseblight[# 5, 0] = 110;
	roseblight[# 5, 1] = 76;
	roseblight[# 5, 2] = 73;
	roseblight[# 6, 0] = 62;
	roseblight[# 6, 1] = 45;
	roseblight[# 6, 2] = 46;
	roseblight[# 7, 0] = 142;
	roseblight[# 7, 1] = 131;
	roseblight[# 7, 2] = 100;

	ds_list_add(global.palettes, roseblight);
#endregion		

#region faded
	var faded = ds_grid_create(8, 3);

	faded[# 0, 0] = 83;
	faded[# 0, 1] = 82;
	faded[# 0, 2] = 140;

	faded[# 1, 0] = 0;
	faded[# 1, 1] = 132;
	faded[# 1, 2] = 134;

	faded[# 2, 0] = 165;
	faded[# 2, 1] = 107;
	faded[# 2, 2] = 49;

	faded[# 3, 0] = 255;
	faded[# 3, 1] = 255;
	faded[# 3, 2] = 58;

	faded[# 4, 0] = 255;
	faded[# 4, 1] = 231;
	faded[# 4, 2] = 197;

	faded[# 5, 0] = 255;
	faded[# 5, 1] = 66;
	faded[# 5, 2] = 0;

	faded[# 6, 0] = 91;
	faded[# 6, 1] = 49;
	faded[# 6, 2] = 91;

	faded[# 7, 0] = 206;
	faded[# 7, 1] = 156;
	faded[# 7, 2] = 133;

	ds_list_add(global.palettes, faded);
#endregion					

#region santicado
	var santicado = ds_grid_create(8, 3);

	santicado[# 0, 0] = 06;
	santicado[# 0, 1] = 35;
	santicado[# 0, 2] = 51;
	santicado[# 1, 0] = 121;
	santicado[# 1, 1] = 189;
	santicado[# 1, 2] = 154;
	santicado[# 2, 0] = 11;
	santicado[# 2, 1] = 72;
	santicado[# 2, 2] = 107;
	santicado[# 3, 0] = 207;
	santicado[# 3, 1] = 240;
	santicado[# 3, 2] = 158;
	santicado[# 4, 0] = 255;
	santicado[# 4, 1] = 255;
	santicado[# 4, 2] = 255;
	santicado[# 5, 0] = 41;
	santicado[# 5, 1] = 233;
	santicado[# 5, 2] = 240;
	santicado[# 6, 0] = 3;
	santicado[# 6, 1] = 18;
	santicado[# 6, 2] = 26;
	santicado[# 7, 0] = 59;
	santicado[# 7, 1] = 134;
	santicado[# 7, 2] = 134;

	ds_list_add(global.palettes, santicado);
#endregion					

#region rustic
	var rustic = ds_grid_create(8, 3);

	rustic[# 0, 0] = 81;
	rustic[# 0, 1] = 69;
	rustic[# 0, 2] = 64;

	rustic[# 1, 0] = 175;
	rustic[# 1, 1] = 77;
	rustic[# 1, 2] = 59;

	rustic[# 2, 0] = 115;
	rustic[# 2, 1] = 130;
	rustic[# 2, 2] = 74;

	rustic[# 3, 0] = 227;
	rustic[# 3, 1] = 201;
	rustic[# 3, 2] = 98;

	rustic[# 4, 0] = 219;
	rustic[# 4, 1] = 209;
	rustic[# 4, 2] = 201;

	rustic[# 5, 0] = 139;
	rustic[# 5, 1] = 100;
	rustic[# 5, 2] = 161;

	rustic[# 6, 0] = 31;
	rustic[# 6, 1] = 39;
	rustic[# 6, 2] = 61;

	rustic[# 7, 0] = 150;
	rustic[# 7, 1] = 139;
	rustic[# 7, 2] = 109;

	ds_list_add(global.palettes, rustic);
#endregion					

#region toxic
	var toxic = ds_grid_create(8, 3);

	toxic[# 0, 0] = 1;
	toxic[# 0, 1] = 32;
	toxic[# 0, 2] = 31;

	toxic[# 1, 0] = 225;
	toxic[# 1, 1] = 167;
	toxic[# 1, 2] = 106;

	toxic[# 2, 0] = 44;
	toxic[# 2, 1] = 139;
	toxic[# 2, 2] = 136;

	toxic[# 3, 0] = 235;
	toxic[# 3, 1] = 150;
	toxic[# 3, 2] = 60;

	toxic[# 4, 0] = 220;
	toxic[# 4, 1] = 241;
	toxic[# 4, 2] = 247;

	toxic[# 5, 0] = 202;
	toxic[# 5, 1] = 121;
	toxic[# 5, 2] = 35;

	toxic[# 6, 0] = 3;
	toxic[# 6, 1] = 40;
	toxic[# 6, 2] = 44;

	toxic[# 7, 0] = 121;
	toxic[# 7, 1] = 157;
	toxic[# 7, 2] = 156;

	ds_list_add(global.palettes, toxic);
#endregion					

#region monotone
	var monotone = ds_grid_create(8, 3);

	monotone[# 0, 0] = 72;
	monotone[# 0, 1] = 61;
	monotone[# 0, 2] = 56;
	monotone[# 1, 0] = 201;
	monotone[# 1, 1] = 183;
	monotone[# 1, 2] = 156;
	monotone[# 2, 0] = 137;
	monotone[# 2, 1] = 122;
	monotone[# 2, 2] = 108;
	monotone[# 3, 0] = 201;
	monotone[# 3, 1] = 183;
	monotone[# 3, 2] = 156;
	monotone[# 4, 0] = 252;
	monotone[# 4, 1] = 245;
	monotone[# 4, 2] = 232;
	monotone[# 5, 0] = 79;
	monotone[# 5, 1] = 69;
	monotone[# 5, 2] = 66;
	monotone[# 6, 0] = 23;
	monotone[# 6, 1] = 15;
	monotone[# 6, 2] = 7;
	monotone[# 7, 0] = 201;
	monotone[# 7, 1] = 183;
	monotone[# 7, 2] = 156;

	ds_list_add(global.palettes, monotone);
#endregion			

#region dogworld
	var dogworld = ds_grid_create(8, 3);

	dogworld[# 0, 0] = 0;
	dogworld[# 0, 1] = 0;
	dogworld[# 0, 2] = 0;
	dogworld[# 1, 0] = 169;
	dogworld[# 1, 1] = 0;
	dogworld[# 1, 2] = 0;
	dogworld[# 2, 0] = 0;
	dogworld[# 2, 1] = 0;
	dogworld[# 2, 2] = 0;
	dogworld[# 3, 0] = 169;
	dogworld[# 3, 1] = 0;
	dogworld[# 3, 2] = 0;
	dogworld[# 4, 0] = 255;
	dogworld[# 4, 1] = 255;
	dogworld[# 4, 2] = 255;
	dogworld[# 5, 0] = 169;
	dogworld[# 5, 1] = 0;
	dogworld[# 5, 2] = 0;
	dogworld[# 6, 0] = 0;
	dogworld[# 6, 1] = 0;
	dogworld[# 6, 2] = 0;
	dogworld[# 7, 0] = 255;
	dogworld[# 7, 1] = 255;
	dogworld[# 7, 2] = 255;

	ds_list_add(global.palettes, dogworld);

#endregion

#region bubble gum
	var bubble_gum = ds_grid_create(8, 3);

	bubble_gum[# 0, 0] = 29;
	bubble_gum[# 0, 1] = 43;
	bubble_gum[# 0, 2] = 83;

	bubble_gum[# 1, 0] = 131;
	bubble_gum[# 1, 1] = 118;
	bubble_gum[# 1, 2] = 156;

	bubble_gum[# 2, 0] = 255;
	bubble_gum[# 2, 1] = 119;
	bubble_gum[# 2, 2] = 168;

	bubble_gum[# 3, 0] = 255;
	bubble_gum[# 3, 1] = 236;
	bubble_gum[# 3, 2] = 39;

	bubble_gum[# 4, 0] = 255;
	bubble_gum[# 4, 1] = 241;
	bubble_gum[# 4, 2] = 232;

	bubble_gum[# 5, 0] = 255;
	bubble_gum[# 5, 1] = 0;
	bubble_gum[# 5, 2] = 77;

	bubble_gum[# 6, 0] = 0;
	bubble_gum[# 6, 1] = 0;
	bubble_gum[# 6, 2] = 0;

	bubble_gum[# 7, 0] = 194;
	bubble_gum[# 7, 1] = 195;
	bubble_gum[# 7, 2] = 199;

	ds_list_add(global.palettes, bubble_gum);
#endregion

#region wave
	var wave = ds_grid_create(8, 3);

	wave[# 0, 0] = 12;
	wave[# 0, 1] = 13;
	wave[# 0, 2] = 20;

	wave[# 1, 0] = 78;
	wave[# 1, 1] = 127;
	wave[# 1, 2] = 125;

	wave[# 2, 0] = 24;
	wave[# 2, 1] = 28;
	wave[# 2, 2] = 40;

	wave[# 3, 0] = 112;
	wave[# 3, 1] = 211;
	wave[# 3, 2] = 139;

	wave[# 4, 0] = 203;
	wave[# 4, 1] = 255;
	wave[# 4, 2] = 216;

	wave[# 5, 0] = 83;
	wave[# 5, 1] = 167;
	wave[# 5, 2] = 136;

	wave[# 6, 0] = 51;
	wave[# 6, 1] = 80;
	wave[# 6, 2] = 93;

	wave[# 7, 0] = 203;
	wave[# 7, 1] = 255;
	wave[# 7, 2] = 216;

	ds_list_add(global.palettes, wave);
#endregion 		

#region lucio
	var lucio = ds_grid_create(8, 3);

	lucio[# 0, 0] = 10;
	lucio[# 0, 1] = 3;
	lucio[# 0, 2] = 13;

	lucio[# 1, 0] = 100;
	lucio[# 1, 1] = 217;
	lucio[# 1, 2] = 147;

	lucio[# 2, 0] = 63;
	lucio[# 2, 1] = 72;
	lucio[# 2, 2] = 204;

	lucio[# 3, 0] = 255;
	lucio[# 3, 1] = 127;
	lucio[# 3, 2] = 39;

	lucio[# 4, 0] = 255;
	lucio[# 4, 1] = 255;
	lucio[# 4, 2] = 247;

	lucio[# 5, 0] = 240;
	lucio[# 5, 1] = 70;
	lucio[# 5, 2] = 79;

	lucio[# 6, 0] = 16;
	lucio[# 6, 1] = 19;
	lucio[# 6, 2] = 54;

	lucio[# 7, 0] = 113;
	lucio[# 7, 1] = 120;
	lucio[# 7, 2] = 217;

	ds_list_add(global.palettes, lucio);
#endregion 					 

#region xan
	var xan = ds_grid_create(8, 3);

	xan[# 0, 0] = 20;
	xan[# 0, 1] = 52;
	xan[# 0, 2] = 74;

	xan[# 1, 0] = 20;
	xan[# 1, 1] = 188;
	xan[# 1, 2] = 135;

	xan[# 2, 0] = 28;
	xan[# 2, 1] = 151;
	xan[# 2, 2] = 163;

	xan[# 3, 0] = 238;
	xan[# 3, 1] = 229;
	xan[# 3, 2] = 1;

	xan[# 4, 0] = 255;
	xan[# 4, 1] = 255;
	xan[# 4, 2] = 247;

	xan[# 5, 0] = 209;
	xan[# 5, 1] = 19;
	xan[# 5, 2] = 34;

	xan[# 6, 0] = 10;
	xan[# 6, 1] = 3;
	xan[# 6, 2] = 13;

	xan[# 7, 0] = 223;
	xan[# 7, 1] = 122;
	xan[# 7, 2] = 1;

	ds_list_add(global.palettes, xan);
#endregion 	

#region cabin
	var cabin = ds_grid_create(8, 3);

	cabin[# 0, 0] = 50;
	cabin[# 0, 1] = 22;
	cabin[# 0, 2] = 99;

	cabin[# 1, 0] = 125;
	cabin[# 1, 1] = 173;
	cabin[# 1, 2] = 255;

	cabin[# 2, 0] = 173;
	cabin[# 2, 1] = 83;
	cabin[# 2, 2] = 3;

	cabin[# 3, 0] = 255;
	cabin[# 3, 1] = 231;
	cabin[# 3, 2] = 92;

	cabin[# 4, 0] = 214;
	cabin[# 4, 1] = 213;
	cabin[# 4, 2] = 222;

	cabin[# 5, 0] = 232;
	cabin[# 5, 1] = 135;
	cabin[# 5, 2] = 203;

	cabin[# 6, 0] = 5;
	cabin[# 6, 1] = 5;
	cabin[# 6, 2] = 23;

	cabin[# 7, 0] = 180;
	cabin[# 7, 1] = 175;
	cabin[# 7, 2] = 222;

	ds_list_add(global.palettes, cabin);
#endregion 	
							
#region zed
	var zed = ds_grid_create(8, 3);

	zed[# 0, 0] = 26;
	zed[# 0, 1] = 9;
	zed[# 0, 2] = 48;

	zed[# 1, 0] = 156;
	zed[# 1, 1] = 154;
	zed[# 1, 2] = 71;

	zed[# 2, 0] = 109;
	zed[# 2, 1] = 99;
	zed[# 2, 2] = 121;

	zed[# 3, 0] = 230;
	zed[# 3, 1] = 186;
	zed[# 3, 2] = 98;

	zed[# 4, 0] = 255;
	zed[# 4, 1] = 233;
	zed[# 4, 2] = 255;

	zed[# 5, 0] = 204;
	zed[# 5, 1] = 82;
	zed[# 5, 2] = 77;

	zed[# 6, 0] = 99;
	zed[# 6, 1] = 11;
	zed[# 6, 2] = 67;

	zed[# 7, 0] = 180;
	zed[# 7, 1] = 145;
	zed[# 7, 2] = 123;

	ds_list_add(global.palettes, zed);
#endregion 

#region placeholder
	var placeholder = ds_grid_create(8, 3);

	placeholder[# 0, 0] = 26;
	placeholder[# 0, 1] = 9;
	placeholder[# 0, 2] = 48;

	placeholder[# 1, 0] = 156;
	placeholder[# 1, 1] = 154;
	placeholder[# 1, 2] = 71;

	placeholder[# 2, 0] = 109;
	placeholder[# 2, 1] = 99;
	placeholder[# 2, 2] = 121;

	placeholder[# 3, 0] = 230;
	placeholder[# 3, 1] = 186;
	placeholder[# 3, 2] = 98;

	placeholder[# 4, 0] = 255;
	placeholder[# 4, 1] = 233;
	placeholder[# 4, 2] = 255;

	placeholder[# 5, 0] = 204;
	placeholder[# 5, 1] = 82;
	placeholder[# 5, 2] = 77;

	placeholder[# 6, 0] = 99;
	placeholder[# 6, 1] = 11;
	placeholder[# 6, 2] = 67;

	placeholder[# 7, 0] = 180;
	placeholder[# 7, 1] = 145;
	placeholder[# 7, 2] = 123;

	ds_list_add(global.palettes, placeholder);
#endregion 

	if (!LEVEL_EDITOR_ENABLED) room_goto(rLogoSplashScreen);

	//instance_create_layer(0,0,layer_create(-1),oGamepadManager);



}
