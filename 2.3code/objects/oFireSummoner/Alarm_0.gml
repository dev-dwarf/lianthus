/// @description
fire_inst = instance_create_layer(x,y,layer,oMagicFire);
fire_inst.sprite_index = sprite_index;
fire_inst.image_xscale = image_xscale;
fire_inst.image_yscale = image_yscale;

oCamera.screenshake += .025;

if (time == -1) instance_destroy();
alarm[1] = time;