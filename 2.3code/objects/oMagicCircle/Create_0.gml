/// @description

// Inherit the parent event
event_inherited();

triggered = false;
clone_z = 0;
max_z = 20;

switch room {
	case rWitchDark:
		if (get_data("throw", false) == true) {
			triggered = true;	
		}
	break;
	case rFieldDark:
		if (get_data("dash", false) == true) {
			triggered = true;	
		}
	break;
	case rEast:
		if (get_data("active_columns", 0) & 8) {
			triggered = true;	
		}
	break;
	case rNorth:
		if (get_data("clone", false)) {
			triggered = true;
		}	
	break;
}