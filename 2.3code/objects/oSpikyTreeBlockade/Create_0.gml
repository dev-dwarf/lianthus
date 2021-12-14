/// @description
instance_destroy();

// Inherit the parent event
event_inherited();

wobble = 0;

if (((get_data("clone", false) and get_data("charge", false)) or (get_data("shadow_defeated", false))) and !LEVEL_EDITOR_ENABLED) {
	var inst = instance_create_layer(x,y,layer,oSpikyTree);
	inst.image_angle = irandom(360);
}