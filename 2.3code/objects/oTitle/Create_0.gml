/// @description
selected = 0;
screen = 0;

move_delay = 0;
delay = 17;

options[0, 0] = get_text_by_index(74);
options[0, 1] = get_text_by_index(75);
options[0, 2] = get_text_by_index(76);
options[0, 3] = get_text_by_index(77);

options[1, 0] = get_text_by_index(78);
options[1, 1] = get_text_by_index(79);
options[1, 2] = get_text_by_index(80);
options[1, 3] = get_text_by_index(81);
options[1, 4] = get_text_by_index(82);
options[1, 6] = get_text_by_index(83);
options[1, 5] = get_text_by_index(84);
options[1, 7] = get_text_by_index(115);
options[1, 8] = get_text_by_index(116);

confirmation_text = get_text_by_index(117);
delete_pressed = false;
									 
options[2, 0] = get_text_by_index(78);
options[2, 1] = "Dev Dwarf";
options[2, 2] = "Lewmoth";
options[2, 3] = "Nol";
options[2, 4] = "Clovelt";

credits_alt_text[0] = "";
credits_alt_text[1] = "@dev_dwarf";
credits_alt_text[2] = "@Lewmothmusic";
credits_alt_text[3] = "@nolnad";
credits_alt_text[4] = "@Clovelt";

alt_text = "";
alt_text_length = 0;

var i = 0;
yes_options[i++] = get_text_by_index(85)
yes_options[i++] = get_text_by_index(86)
yes_options[i++] = get_text_by_index(87)
yes_options[i++] = get_text_by_index(88)
yes_options[i++] = get_text_by_index(89)
yes_options[i++] = get_text_by_index(90)

var i = 0;
no_options[i++] = get_text_by_index(91)
no_options[i++] = get_text_by_index(92)
no_options[i++] = get_text_by_index(93)
no_options[i++] = get_text_by_index(94)
no_options[i++] = get_text_by_index(95)
no_options[i++] = get_text_by_index(96)

yes_no_index = 0;
draw_index = 0;
max_draw = 7;

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
side_delay = 6;

in_position = 0;
go_away = false;
selected_boost = 8;

last_screen = screen;

oPlayer.state = player.talk;

