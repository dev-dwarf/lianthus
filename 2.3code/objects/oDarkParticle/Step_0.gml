/// @description
zspeed = lerp(zspeed, 0, 0.1);
speed = lerp(speed, 0, 0.1);

z += zspeed;

if (zspeed <= 0 or image_index >= image_number-1) instance_destroy();