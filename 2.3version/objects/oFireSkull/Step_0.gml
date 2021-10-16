/// @description

if (instance_exists(oPause) or global.oldest_player.state == player.dead or oShadow.state == shadow.defeated) exit;

speed = approach(speed, 0, deceleration);

if (speed == 0) {
	instance_destroy();
	instance_create_layer(x,y,layer,oSkull);
}

var inst = instance_place(x,y,oPlayer)
if (inst and inst.just_hit <= 0) {
	inst.hp -= 1.5;
	oCamera.screenshake = .40;
	inst.just_hit = 30;
	
	if (inst.state == player.dead) {
		instance_destroy(inst);	
	}
	
	speed *= 0.5;
	
	play_sound(sndPlayerHit, 25, false, 1.0, 0.2, sound_effect_volume);	
}

if (speed > 0.5) {
	scale = lerp(scale, 1.00, 0.2);
} else {
	scale = lerp(scale, 0.75, 0.5);
}

if (dcos(direction + oCamera.angle) != 0) {

	image_xscale = sign(dcos(direction + oCamera.angle));

}