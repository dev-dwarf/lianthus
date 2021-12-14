///@desc gamepad_anykey
///@param slot
function gamepad_anykey(argument0) {

	for ( var i = gp_face1; i < gp_axisrv; i++ ) {
	    if ( gamepad_button_check( argument0, i ) ) return i;
	}

	if (abs(gamepad_axis_value(argument0, gp_axislh) != 0) or
		abs(gamepad_axis_value(argument0, gp_axislv) != 0) or 
		abs(gamepad_axis_value(argument0, gp_axisrh) != 0) or 
		abs(gamepad_axis_value(argument0, gp_axisrv) != 0)) {
		return true;	
	}

	return false;


}
