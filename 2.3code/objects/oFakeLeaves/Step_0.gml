/// @description

if place_meeting(x,y,oBonesplosion) {
	wobble = 1;
		
	if (has_birds) {
	birdtimer--;	
		if (birdtimer < 0) {
			
		
			//create 1 to 3 birds
			repeat(choose(1,1,2,2,3)) {
				var inst = instance_create_layer(  x + irandom_range(-20, 20) - oCamera.x_step * 10,	
										y + irandom_range(-20, 20) - oCamera.y_step * 10,	
										layer,
										oCrow);
				inst.flying = true;				inst.z = 90;

			}
		
			//birdtimer = 40;
			has_birds = false;
		}
	} 
}

wobble = lerp(wobble, 0, 0.1);