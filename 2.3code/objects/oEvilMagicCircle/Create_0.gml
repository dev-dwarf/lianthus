/// @description

// Inherit the parent event
event_inherited();

triggered = false;
clone_z = 0;
max_z = 20;

white	= make_color_rgb(255, 255, 247);
red		= make_color_rgb(255, 0, 89);

if (get_data("finale", false)) {
	instance_change(oMagicDoor, true);
}