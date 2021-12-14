/// @description
zspeed = lerp(zspeed, 0.5, 0.05);
speed = lerp(speed, 0.25, 0.1);

z += zspeed;

if (zspeed >= .48) instance_destroy();