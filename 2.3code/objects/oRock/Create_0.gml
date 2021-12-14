/// @description

// Inherit the parent event
event_inherited();

wobble = 0;
up = true;
image_zscale = 2.0;

collision_instance = instance_create_layer(x,y,layer,pHitbox);
collision_instance.mask_index = mask_index;
collision_instance.sprite_index = sprite_index;


if (global.dark[room]) {
	base_sprite = sRockDark;
	cracked_sprite =  sRockCrackedDark;
	down_sprite = sRockShatteredDark;
} else {
	base_sprite = sRock;
	cracked_sprite = sRockCracked;
	down_sprite = sRockShattered;
}

sprite_index = base_sprite;