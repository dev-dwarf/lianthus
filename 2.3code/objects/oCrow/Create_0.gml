/// @description

z = 40;


move_speed = 1;

last_flying = false;
flying = false;

sprite_index = choose(sCrowSit1, sCrowSit2);

shadow_defeated = get_data("shadow_defeated", false);

x += random_range(-2, 2);
y += random_range(-2, 2);