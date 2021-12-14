/// @description
if (distance_to_object(oPlayer) < 35) {
	triggered = true;	
	scale = lerp(scale, 0, 0.2);	
} else if (triggered) {
	scale = lerp(scale, 1, 0.2);	
} else {
	scale = lerp(scale, 0, 0.2);	
}