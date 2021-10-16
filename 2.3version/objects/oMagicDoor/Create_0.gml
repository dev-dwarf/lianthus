/// @description
z = -5;
// Inherit the parent event
event_inherited();

locked = get_data("doorLocked" + string(room), true) or get_data("shadow_defeated", false);
immune = false;
transition_triggered = false;
index = 0;
unlock_timer = 0;
wobble = 0;

forced_activated = false;

//if (locked) {
	collision_instance = instance_create_layer(x,y,layer, pHitbox);
	collision_instance.mask_index   = sMagicDoorClosed;
	collision_instance.sprite_index = sMagicDoorClosed;
//}

if (!locked) instance_destroy(collision_instance);
	
mask_index   = sMagicDoorClosed;
	
connected_room[rWitch	 ]	= rWitchDark;
connected_room[rWitchDark]	= rWitch;

connected_room[rField	 ]	= rFieldDark;
connected_room[rFieldDark]	= rField;

connected_room[rFlats	 ]	= rFlatsDark;
connected_room[rFlatsDark]	= rFlats;

connected_room[rEast	 ]	= rEastDark;
connected_room[rEastDark]	= rEast;

connected_room[rDog		 ]	= rDogDark;
connected_room[rDogDark]	= rDog;

connected_room[rPath	]	= rPathDark;
connected_room[rPathDark]	= rPath;

connected_room[rNorth	]	= rNorthDark;
connected_room[rNorthDark]	= rNorth;

connected_room[rEnd	]		= rEndDark;
connected_room[rEndDark]	= rEnd;

if (global.dark[room]) {
	transition_sprite = sTransitionDark;	
	
	if (chance(25) or true) {
		alarm[0] = 120;

	}
} else {
	transition_sprite = sTransition;	
}