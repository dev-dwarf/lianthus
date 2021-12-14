/// @description

// Inherit the parent event
event_inherited();

move_speed = 0;
move_direction = 0;
broken = false;

go_up = false;

collision_instance = instance_create_layer(x,y,layer,pHitbox);
collision_instance.mask_index = mask_index;
collision_instance.sprite_index = sprite_index;

image_xscale = 1.5;
image_yscale = 1.5;