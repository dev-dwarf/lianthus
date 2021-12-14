/// @description
if (active or oPlayer.hover) {
	sprite_index = sPillarActive;

	if (chance(40)) {
		var inst = instance_create_layer(x, y, layer, oDustParticle);
		inst.z = 26;
	}
} else {
	sprite_index = sPillar;
	
	if (chance(40)) {
		var inst = instance_create_layer(x, y, layer, oDarkParticle);
		inst.z = 22;
	//	inst.image_blend = make_color_rgb(10, 3, 13)
		//if (chance(2)) inst.image_blend = make_color_rgb(255, 0, 89)
	}

}