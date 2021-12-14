/// @description
event_inherited();

erase_me = -1;

if (instance_number(oPlayer) == 1) {
	global.oldest_player = id;	
}


enum player {
	idle,
	walk,
	dead,
	talk
}

compass_unlocked = get_data("compass_unlocked", false);

state = player.idle;
move_speed = 0;
move_speed_max = 0.74;
move_direction = 0;
face_index = 0;

hp = 3;

in_control_of_camera = true;
hand_sprite = sBoneIdle;
idle_time = 0;

attack_alarm = 0;
attack_cooldown = 40;
bone_speed = 3.0;

teleport_alarm = 0;	
teleport_cooldown = 31;
dash_price = -1;
dash_distance = 65;

last_flowers = get_data("flowers", 0);
last_keys = get_data("keys", 0);

flower_gui_scale = 0;
key_gui_scale = 0;

just_hit = 0;

made_footstep = false;

hover = get_data("hover", false) and (room == rShrine) ;
hover_sprite = sPlayerHover;

mask_index = sPlayerShadow;

throw_unlocked  = get_data("throw", false) or LEVEL_EDITOR_ENABLED;
dash_unlocked	= get_data("dash", false) or LEVEL_EDITOR_ENABLED;
charge_unlocked = get_data("charge", false) or LEVEL_EDITOR_ENABLED;
shield_unlocked = false;

clone_unlocked = get_data("clone", false) or LEVEL_EDITOR_ENABLED;
enter_unlocked = get_data("enter", false) or LEVEL_EDITOR_ENABLED;

charge_time = 0;
charge_max = 50;

spell_time = 0;
spell_max = 120;
shield_cooldown = 120;
shield_active = false;
shield_timer = 0;

camera_x_axis = 0;
camera_y_axis = 0;

gamepad_set_axis_deadzone(global.gamepad_slot, 0.4);

globalvar magic_particles;
magic_particles = part_system_create()
part_system_depth(magic_particles, -50);

magic_particle = part_type_create();
part_type_sprite(magic_particle, sSunflowerBitsParticle, true, true, false);
part_type_direction(magic_particle, 0, 360, 1, -2);
part_type_speed(magic_particle, 0.4, 0.5, -0.005, 0);
part_type_life(magic_particle, 10, 15);
part_type_orientation(magic_particle, 0, 360, 2, 0, true);

dark_magic_particle = part_type_create();
part_type_sprite(dark_magic_particle, sDarkMagicParticle, true, true, false);
part_type_direction(dark_magic_particle, 0, 360, 1, -2);
part_type_speed(dark_magic_particle, 0.5, 0.6, -0.005, 0);
part_type_life(dark_magic_particle, 8, 12);
part_type_orientation(dark_magic_particle, 0, 360, 2, 0, true);

shield_particle = part_type_create();
part_type_sprite(shield_particle, sShieldParticle, true, true, false);
part_type_direction(shield_particle, 0, 360, 1, -2);
part_type_speed(shield_particle, 0.4, 0.5, -0.005, 0);
part_type_life(shield_particle, 9, 13);
part_type_orientation(shield_particle, 0, 360, 4, 0, true);

possesed = false;
possesed_time = 0;
possesion_complete_time = 5 * 60;


lerped_hp = hp;

// prevent stuck inside things
var checks = 0;
var radius = 4; var angle = 0;
while (place_meeting(x,y,pSolid)) {
	if (!place_meeting(x + lengthdir_x(radius, angle), y + lengthdir_y(radius, angle), pSolid)) {
		x += lengthdir_x(radius, angle);
		y += lengthdir_y(radius, angle);
		break;
	}
	
	angle += 30;
	
	if (angle == 360) {
		radius += 4;
		angle  = 30;
		checks++;
	}
	
	if (checks > 4) state = player.dead;
}

if (global.oldest_player != id) {
	image_xscale = 0.2;
	image_yscale = 0.2;
	erase_me = 8 * 60 + irandom(60);
	
	if (instance_exists(oShadow)) {
		erase_me = 20 * 60 + irandom(60);
	}
}