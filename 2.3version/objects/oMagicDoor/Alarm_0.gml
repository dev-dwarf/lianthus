/// @description
repeat 3 + chance(25) + chance(10) {
	var inst = instance_create_layer(oPlayer.x + irandom_range(-16, 16), oPlayer.y  + irandom_range(-16, 16), layer, oCrow);
	inst.z = 40;
}