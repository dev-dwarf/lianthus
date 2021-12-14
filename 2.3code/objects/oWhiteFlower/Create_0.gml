/// @description
up_sprite = sprite_index;
down_sprite = sSunflowerLargeBarren
// Inherit the parent event
event_inherited();

state = "full"
wobble = 0;

if (global.dark[room]) {
	up_sprite = sWhiteFlowerDark;
	down_sprite = sEyeflowerLargeBarren
}
