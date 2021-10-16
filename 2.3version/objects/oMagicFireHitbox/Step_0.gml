/// @description

var inst = instance_place(x,y,oPlayer);

if (inst) {
	while (inst.state == player.dead) {
		if (instance_number(oPlayer) == 1) break;
		
		instance_destroy(inst);
		inst = instance_place(x,y,oPlayer);
	
		if (inst == noone) exit;
	}
	
	
	damage_alarm--;
		
	if (damage_alarm <= 0 and inst.just_hit <= 0 and inst.hp > 0) {
		//log("damaged: " + string(current_time));
		damage_alarm = 20;
		inst.hp -= 0.25;
		inst.just_hit = 30;
		play_sound(sndPlayerHit, 25, false, 1.0, 0.2, sound_effect_volume);
	}
} else {
	damage_alarm = 20;
}