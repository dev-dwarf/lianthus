/// @description
selected = 0;

move_delay = 0;
delay = 17;
side_delay = 0;

destroy = false;

options[0] = get_text_by_index(78);
options[1] = get_text_by_index(79);
options[2] = get_text_by_index(80);
options[3] = get_text_by_index(81);
options[4] = get_text_by_index(82);
options[5] = get_text_by_index(77)

var i = 0;
palette_names[i++] = "Default"  ;
palette_names[i++] = "Vintage"  ;
palette_names[i++] = "Autumn"	 ;
palette_names[i++] = "Dawn"	  ;
palette_names[i++] = "Lemongrab";
palette_names[i++] = "Witching" ;
palette_names[i++] = "Vivid"	  ;
palette_names[i++] = "Forest"	  ;
palette_names[i++] = "Coppertone";
palette_names[i++] = "Candycorn";
palette_names[i++] = "Sepia"	  ;
palette_names[i++] = "DOS" 	  ;
palette_names[i++] = "Roseblight";
palette_names[i++] = "Faded" 	  ;
palette_names[i++] = "Santicado";
palette_names[i++] = "Rustic"	  ;
palette_names[i++] = "Toxic"	  ;
palette_names[i++] = "Monotone" ;
palette_names[i++] = "Dogworld" ;
palette_names[i++] = "Bubblegum";
palette_names[i++] = "Wave"	  ;
palette_names[i++] = "Lucio"	  ;
palette_names[i++] = "Xan"	  ;
palette_names[i++] = "Cabin"	  ;
palette_names[i++] = "Zed"	  ;

color = make_color_rgb(255, 207, 0);
underline_color = make_color_rgb(0, 77, 87)
selected_color = make_color_rgb(255, 255, 247);

selected_underline_color = make_color_rgb(121, 115, 102)

if (global.dark[room]) {
	color = make_color_rgb(255, 0, 89);
	underline_color = make_color_rgb(10, 3, 13)	
} else {
	color = make_color_rgb(255, 207, 0);
	underline_color = make_color_rgb(0, 77, 87)	
}

prev_camera_zscale = oCamera.image_zscale;

in_position = 0;
go_away = false;
selected_boost = 8;

key_gui_scale    = 0
flower_gui_scale = 0

