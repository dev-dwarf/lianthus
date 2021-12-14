/// @description
var inst = instance_place(x,y,oBone);
if (inst) {
	instance_destroy(inst);
}

if (place_meeting(x,y,oBonesplosion)) {
	
	instance_destroy();	
}