/// @description
image_angle = 45;

if (shadow_defeated or oPlayer.hover) {
	sprite_index = sShrineActive;
	repeat (3) {
		var inst = instance_create_layer(x + random_range(-6, 6), y + random_range(-6, 6), layer, oDustParticle);
		inst.z = 9;
	}
} else {
	sprite_index = sShrine;
	repeat (2) {
		var inst = instance_create_layer(x + random_range(-6, 6), y + random_range(-6, 6), layer, oDarkParticle);
		inst.z = 9;
		//inst.image_blend = make_color_rgb(10, 3, 13)
	}
}

