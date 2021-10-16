/// @description

// Inherit the parent event
event_inherited();

wobble = 0;
up = true;

collision_instance = instance_create_layer(x,y,layer,pHitbox);
collision_instance.mask_index = mask_index;
collision_instance.sprite_index = sprite_index;