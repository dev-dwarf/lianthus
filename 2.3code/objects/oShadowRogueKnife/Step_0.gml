/// @description

if (instance_exists(oPause) or global.oldest_player.state == player.dead or oShadow.state == shadow.defeated) exit;

if (distance_to_object(oShadowRogue) > 500) instance_destroy();

image_angle = direction;

var inst = instance_place(x,y,oPlayer)
if (inst and inst.just_hit <= 0) {
	inst.hp -= 1.5;
	oCamera.screenshake = .40;
	inst.just_hit = 30;
	
	if (inst.state == player.dead and global.oldest_player != inst) {
		instance_destroy(inst);	
	}
	
	speed *= 0.5;
	
	if (speed < 1) {
		instance_destroy();	
	}
	
	play_sound(sndPlayerHit, 25, false, 1.0, 0.2, sound_effect_volume);	
}


scale = lerp(scale, 1.00, 0.2);
