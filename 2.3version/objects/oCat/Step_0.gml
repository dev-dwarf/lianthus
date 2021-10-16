/// @description
if (instance_exists(oPause)) exit;


if (room == rForest or room == rWitch or room == rWitchDark)
	and oPlayer.throw_unlocked and !LEVEL_EDITOR_ENABLED {
		instance_destroy();	
}

if get_data("dog_defeated", false) and !LEVEL_EDITOR_ENABLED {
	instance_destroy();	
}


if (!hidden and distance_to_object(oPlayer) < 80 ) {
	hidden = true;	
	
	if (global.dark[room]) {
		instance_create_layer(x + irandom_range(-8, 8), y + irandom_range(-8, 8), layer, oFireParticle);
		
		play_sound(sndCatPoof, 10, false, 0.4, 0.1, sound_effect_volume);
	} else {
		repeat(3)
			instance_create_layer(x + irandom_range(-8, 8), y + irandom_range(-8, 8), layer, oDustParticle);
			
		play_sound(sndCatPoof, 10, false, 1.3, 0.1, sound_effect_volume);
	}
	
}