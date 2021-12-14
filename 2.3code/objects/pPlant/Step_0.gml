/// @description
if (up) {
	collision_instance.x = x;
	collision_instance.y = y;
}

if place_meeting(x,y,oBonesplosion) and up  {
	wobble = 1;
	up = false;
	instance_destroy(collision_instance);
	collision_instance = noone;
	sprite_index = down_sprite;
	
	var r = sprite_width/2 - 4
	
	instance_create_layer(x + r + irandom_range(-2, 2), y - r + irandom_range(-2, 2), layer, oDustParticle);
	instance_create_layer(x - r + irandom_range(-2, 2), y + r + irandom_range(-2, 2), layer, oDustParticle);
	instance_create_layer(x + r + irandom_range(-2, 2), y + r + irandom_range(-2, 2), layer, oDustParticle);
	instance_create_layer(x - r + irandom_range(-2, 2), y - r + irandom_range(-2, 2), layer, oDustParticle);
	
	repeat(chance(30) + chance(20))
		instance_create_layer(x + irandom_range(-r, r), y + irandom_range(-r, r), layer, oDustParticle);
}

wobble = lerp(wobble, 0, 0.1);
