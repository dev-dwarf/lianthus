///@function draw_stacked
///@param sprite_index
///@param x
///@param y
///@param z
function draw_stacked_sprite() {

	var _sprite_index	= argument[0];
	var _x				= argument[1];
	var _y				= argument[2];
	var _z				= argument[3];

	var _image_zscale = oCamera.image_zscale

	// compute the amount we move each layer by
	// default direction is up (90*), and then add camera gnle
	var _x_step = oCamera.x_step * _image_zscale;
	var _y_step = oCamera.y_step * _image_zscale;
	var _z_step = oCamera.z_step;
	var _z_height = sprite_get_number(_sprite_index);

	// loop through each slice of the sprite, moving by x and y step each time
	for (var i = 0; i < _z_height; i += _z_step) {
		draw_sprite(_sprite_index, i, _x - _x_step * (i+_z), _y - _y_step * (i+_z));
	}


}
