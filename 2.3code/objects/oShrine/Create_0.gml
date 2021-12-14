/// @description

// Inherit the parent event
event_inherited();

active_columns = get_data("active_columns", 0);
shadow_defeated = get_data("shadow_defeated", false);
image_angle = 45;
z = 0;

columns[0] = instance_create_layer(x, y - sqrt(2) * sprite_width/2, layer, oShrineColumn);
columns[2] = instance_create_layer(x, y + sqrt(2) * sprite_width/2 , layer, oShrineColumn);
columns[3] = instance_create_layer(x - sqrt(2) * sprite_width/2, y , layer, oShrineColumn);
columns[1] = instance_create_layer(x + sqrt(2) * sprite_width/2, y , layer, oShrineColumn);

columns[0].active = (active_columns & 1) or shadow_defeated;
columns[1].active = (active_columns & 2) or shadow_defeated;
columns[2].active = (active_columns & 4) or shadow_defeated;
columns[3].active = (active_columns & 8) or shadow_defeated;

if room == rShrine and global.last_room == rShrineDark {
	var inst = instance_create_layer(x,y,layer,oWitchTransition);
	inst.radius = 600;
}