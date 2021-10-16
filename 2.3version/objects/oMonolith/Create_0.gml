/// @description

// Inherit the parent event
event_inherited();

image_xscale = 0.85;
image_yscale = 0.85;

wobble = 0;
image_zscale = 2.4;
active = true;

if (y == -169) {
	text[0] = get_text_by_index(61);
	text[1] = get_text_by_index(62);	
	text[2] = get_text_by_index(63);
} else if (y == -37) {
	text[0] = get_text_by_index(67);
	text[1] = get_text_by_index(68);	
	text[2] = get_text_by_index(69);
} else {
	text[0] = get_text_by_index(64);
	text[1] = get_text_by_index(65);	
	text[2] = get_text_by_index(66);

}

text_index = 0;

//collision_instance = instance_create_layer(x,y,layer,pHitbox);
//collision_instance.mask_index = mask_index;
//collision_instance.sprite_index = sprite_index;
