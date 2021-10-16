///@desc angle_lerp
///@param in
///@param target
///@param percent
function angle_lerp(argument0, argument1, argument2) {
	var angle = (argument0 - angle_difference(argument0, argument1) * argument2)

	while(angle < 0) angle+=360;
	while(angle >= 360) angle -= 360;

	return angle;


}
