/// @description
if (!LEVEL_EDITOR_ENABLED) instance_destroy();

enum areas {
	field,
	forest,
	spooky,
	mountain,
	cave
}

editor_open = false;
selected_object = noone;

brush_mode = false;
grid_enabled = false;

objects_menu = 0;

text_colors = ds_map_create();
text_colors[? "save"] = c_white;
text_colors[? "load"] = c_white;
text_colors[? "grid"] = c_white;

place_list = ds_list_create();

cursor_changed = 0;
trashed_object = 0;

text_hover_color = make_color_rgb(255, 207, 0)

preview_height = 100;
preview_angle = 60;
preview_selected = noone;
preview_list_position = 0;
preview_list_max_items = 14;

area = areas.forest;

preview_list[areas.forest] = ds_list_create();
ds_list_add(preview_list[areas.forest], oLevelTransition); //virtual
ds_list_add(preview_list[areas.forest], oPointOfInterest);
ds_list_add(preview_list[areas.forest], oInvisbleWall);

ds_list_add(preview_list[areas.forest], oSunflower); //plants
ds_list_add(preview_list[areas.forest], oSmallSunflower);
ds_list_add(preview_list[areas.forest], oPoppy);
ds_list_add(preview_list[areas.forest], oTree);
ds_list_add(preview_list[areas.forest], oWhiteFlower);

ds_list_add(preview_list[areas.forest], oBush);
ds_list_add(preview_list[areas.forest], oFakeTree);
ds_list_add(preview_list[areas.forest], oFakeBush);
ds_list_add(preview_list[areas.forest], oFakeLeaves);
ds_list_add(preview_list[areas.forest], oGrass);
ds_list_add(preview_list[areas.forest], oWheat);


ds_list_add(preview_list[areas.forest], oFloorCrack); //rocks/manmade
ds_list_add(preview_list[areas.forest], oFloor); 
ds_list_add(preview_list[areas.forest], oBones);
ds_list_add(preview_list[areas.forest], oSpikyTreeBlockade);


ds_list_add(preview_list[areas.forest], oPath);
ds_list_add(preview_list[areas.forest], oRock);
ds_list_add(preview_list[areas.forest], oRockOutcropping);
ds_list_add(preview_list[areas.forest], oSkull);
ds_list_add(preview_list[areas.forest], oOrb);
ds_list_add(preview_list[areas.forest], oMagicFire);
ds_list_add(preview_list[areas.forest], oDogDoor);

ds_list_add(preview_list[areas.forest], oMagicCircle);
ds_list_add(preview_list[areas.forest], oMagicDoor);
ds_list_add(preview_list[areas.forest], oWitchesHouse);

ds_list_add(preview_list[areas.forest], oShrine);
ds_list_add(preview_list[areas.forest], oKey);
ds_list_add(preview_list[areas.forest], oSpikyTree);
ds_list_add(preview_list[areas.forest], oSpikyTreeBlockade);

ds_list_add(preview_list[areas.forest], oFakeSpikyTree);
ds_list_add(preview_list[areas.forest], oFlowerDark);
ds_list_add(preview_list[areas.forest], oFloorCrackDark);
ds_list_add(preview_list[areas.forest], oShrineColumn);

ds_list_add(preview_list[areas.forest], oDarkStalk);

ds_list_add(preview_list[areas.forest], oMonolith);
ds_list_add(preview_list[areas.forest], oGrave);
ds_list_add(preview_list[areas.forest], oHeadstone);

ds_list_add(preview_list[areas.forest], oCrow);
ds_list_add(preview_list[areas.forest], oDog);
ds_list_add(preview_list[areas.forest], oWitch);
ds_list_add(preview_list[areas.forest], oBoy);
ds_list_add(preview_list[areas.forest], oRogue);

ds_list_add(preview_list[areas.forest], oCat);
ds_list_add(preview_list[areas.forest], oSanticado);
ds_list_add(preview_list[areas.forest], oChumbo);
ds_list_add(preview_list[areas.forest], oSkullHorned);
ds_list_add(preview_list[areas.forest], oNop);
ds_list_add(preview_list[areas.forest], oCompass);

ds_list_add(preview_list[areas.forest], oDogMagicCircle);

ds_list_add(preview_list[areas.forest], oEye);
ds_list_add(preview_list[areas.forest], oPalette);
ds_list_add(preview_list[areas.forest], oOldHouseTopLeft);
ds_list_add(preview_list[areas.forest], oOldHouseBotLeft);
ds_list_add(preview_list[areas.forest], oOldHouseRight);
ds_list_add(preview_list[areas.forest], oOldHouseRightBot);
ds_list_add(preview_list[areas.forest], oTable);


right_side_width = 160;
right_side_x = display_get_gui_width()-right_side_width;
text_y = 15;

depth = -10;