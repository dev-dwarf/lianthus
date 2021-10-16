/// @description
if (up) {
	collision_instance.x = x;
	collision_instance.y = y;
}

var inst = instance_place(x,y,oBonesplosion)
if inst and up and wobble < 0.2 {
	wobble = 2;
	
	play_sound(sndRockHit, 40, false, 1.0 - global.dark[room] * 0.3, 0.1, sound_effect_volume);

	if sprite_index == base_sprite and !(inst.flower_charged > 1) {
		sprite_index = cracked_sprite;
		image_zscale = 1.6
	} else {	
		
		image_zscale = 1.0
		up = false;
		z = -30
		instance_destroy(collision_instance);
		collision_instance = noone;
		sprite_index = down_sprite;
	}
	
	var r = sprite_width/2 - 4
	
	instance_create_layer(x + r + irandom_range(-2, 2), y - r + irandom_range(-2, 2), layer, oDustParticle);
	instance_create_layer(x - r + irandom_range(-2, 2), y + r + irandom_range(-2, 2), layer, oDustParticle);
	instance_create_layer(x + r + irandom_range(-2, 2), y + r + irandom_range(-2, 2), layer, oDustParticle);
	instance_create_layer(x - r + irandom_range(-2, 2), y - r + irandom_range(-2, 2), layer, oDustParticle);
	
	repeat(chance(30) + chance(20))
		instance_create_layer(x + irandom_range(-r, r), y + irandom_range(-r, r), layer, oDustParticle);
}

wobble = lerp(wobble, 0, 0.1);