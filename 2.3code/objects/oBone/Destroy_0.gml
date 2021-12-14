/// @description
with instance_create_layer(x + lengthdir_x(2*move_speed, direction),y + lengthdir_y(2*move_speed, direction),layer,oBonesplosion) {
	z = other.z;	
	flower_charged = other.flower_charged
}


oCamera.screenshake = 0.15 + 0.05 * flower_charged;