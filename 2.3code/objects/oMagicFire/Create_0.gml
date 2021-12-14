/// @description

// Inherit the parent event
event_inherited();

active = true;
damage_alarm = 5;

collision_instance = instance_create_layer(x,y,layer,oMagicFireHitbox);
collision_instance.sprite_index = sprite_index;
collision_instance.image_xscale = image_xscale;
collision_instance.image_yscale = image_yscale;				
collision_instance.image_angle	= image_angle;			

sound_max_range = 80;
sound_close_range = 10;
sound_id = noone;