/// @description
event_inherited();

active = false;

active_alarm = 40;

z = -1060

collision_instance = instance_create_layer(x,y,layer, oInvisbleWall);
	collision_instance.mask_index   = sBridge;
	collision_instance.sprite_index = sprite_index;