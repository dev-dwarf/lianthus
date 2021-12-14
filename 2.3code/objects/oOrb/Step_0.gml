/// @description
if (place_meeting(x,y,oBonesplosion) and hit_alarm <= 0 and !active) {
	active = true;	
	hit_alarm = 15;
	
	if (instance_exists(oMagicFire)) 
		oMagicFire.active = false;	
}

if (hit_alarm) hit_alarm--;

if (sprite_index != sOrbDeactive) {
	if (active) {
		sprite_index = sOrbActive;

		if (chance(40)) {
			var inst = instance_create_layer(x, y, layer, oDustParticle);
			inst.z = 9;
		}
	} else {
		sprite_index = sOrb;
	
		if (instance_exists(oMagicFire)) 
			oMagicFire.active = true;	
		
		if (chance(40)) {
			var inst = instance_create_layer(x, y, layer, oFireParticle);
			inst.z = 9;
			inst.image_xscale = 0.5;
			inst.image_yscale = 0.5;
		}
	}
}