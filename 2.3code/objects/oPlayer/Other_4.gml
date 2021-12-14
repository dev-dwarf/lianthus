/// @description
if (global.last_room != noone) {
	var inst = noone;
	with oLevelTransition { // loop through all these
		if (target_room == global.last_room) { // if it leads to the previous room
			inst = id;
		}
	}
	
	if (inst != noone) {
		inst.immune = true;
		x = inst.x;
		y = inst.y;
	}
} 
