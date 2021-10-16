/// @description

if (text_index < 3) {
	if place_meeting(x,y,oBonesplosion) and wobble < 0.2 and active {
		wobble = 2;
		active = false;
	
		dialogue_instance = instance_create_layer(oCamera.x, oCamera.y, layer, pText);
		dialogue_instance.text = text[text_index];
		dialogue_instance.text_speed = 0.4;
		dialogue_instance.pos = 90;
		dialogue_instance.destroy = 70 + string_length(text[text_index]) * 3;
		text_index++;
	}
	
	if (!active and !instance_exists(pText)) {
		active = true;
	}	
} 

if (active) {
	if (chance(40)) {
		var inst = instance_create_layer(x + irandom_range(-2, 2), y + irandom_range(-2, 2), layer, oDustParticle);
		inst.z = image_number * image_zscale * image_xscale/0.85;
	}	
	sprite_index = sMonolithActive
} else {
	sprite_index = sMonolith	
}

wobble = lerp(wobble, 0, 0.1);