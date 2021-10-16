/// @description
//event_inherited();
//z = -1000;

target_room = noone;

transition_triggered = false;
index = 0;
immune = false;

alarm[0] = 1;

if (global.dark[room]) {
	transition_sprite = sTransitionDark;	
} else {
	transition_sprite = sTransition;	
}