/// @description
zspeed = lerp(zspeed, 0.5, 0.05);
speed = lerp(speed, 0.25, 0.1);

image_angle += 2;

z += zspeed;

if (zspeed == 1.5 or image_index >= image_number-1) instance_destroy();