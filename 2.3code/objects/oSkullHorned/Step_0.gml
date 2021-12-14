/// @description
//if (LEVEL_EDITOR_ENABLED) exit;

//image_xscale = 1.5;
//image_yscale = 1.5;
//if (place_meeting(x,y,oPlayer)) {
//	move_speed = oPlayer.move_speed * 4;
//	move_direction = oPlayer.move_direction + irandom_range(-10, 10);
//}
//image_xscale = 1.0;
//image_yscale = 1.0;

if (!instance_exists(global.oldest_player)) exit;
if (broken or global.oldest_player.state == player.dead) exit;

move_speed = approach(move_speed, 0, 0.2);
image_angle += move_speed;

x += lengthdir_x(move_speed, move_direction - oCamera.angle);
y += lengthdir_y(move_speed, move_direction - oCamera.angle);

if (place_meeting(x,y, oBonesplosion)) and !broken {
	// create particles	
	var r = sprite_width/2
	repeat(1 + chance(30) + chance(20))
		instance_create_layer(x + random_range(-r, r), y + random_range(-r, r), layer, oDustParticle);
		
	instance_destroy(collision_instance);
	broken = true;
}
