/// @description
event_inherited();

z = 33 + irandom(5);
//y += z;

has_birds = chance(20) or true;
birdtimer = 10;
wobble = 0;

image_speed = 0;
image_index = 0;

if (global.dark[room]) {
	sprite_index = sDarkLeaves;	
	z = -z;
}