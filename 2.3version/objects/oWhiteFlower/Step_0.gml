/// @description

switch state {
	case "full":
	sprite_index = up_sprite;
	
	//var inst = instance_place(x,y,oBone)
	//if inst {
	//	instance_destroy(inst);
	//}
	
	if (place_meeting(x,y,oBone) or place_meeting(x,y,oBonesplosion)) and wobble == 0 {
		wobble = 2.0;
		state = "barren";
		
		play_sound(sndSwoosh, 40, false, 1.35, 0.3, sound_effect_volume);

		
		var r = 4
		repeat(1 + chance(75) + chance(50) + chance(40))
			instance_create_layer(x + irandom_range(-r, r), y + irandom_range(-r, r), layer, oDustParticle);
			
	}

	break;
	case "barren":
	sprite_index = down_sprite;
	
	if place_meeting(x,y,oBonesplosion) and wobble == 0 {
		wobble = 1.0;
		
		var r = 4
		repeat(2)
			instance_create_layer(x + irandom_range(-r, r), y + irandom_range(-r, r), layer, oDustParticle);
	}
	
	break			
}

wobble = lerp(wobble, 0, 0.1);