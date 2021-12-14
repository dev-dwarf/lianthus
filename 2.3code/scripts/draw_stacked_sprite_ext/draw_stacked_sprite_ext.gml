///@function draw_stacked
///@param sprite_index
///@param x
///@param y
///@param z
///@param image_xscale
///@param image_yscale
///@param image_zscale
///@param image_angle
///@param wobble?
///@param wind?
function draw_stacked_sprite_ext() {


	var _sprite_index	= argument[0];
	var _x				= argument[1];
	var _y				= argument[2];
	var _z				= argument[3];
	var _image_xscale	= argument[4];
	var _image_yscale	= argument[5];
	var _image_zscale	= argument[6];
	var _image_angle	= argument[7];
	//var image_alpha //making alpha work with sprite stacking is out of scope of this tutorial

	var _shake = 0;
	if (argument_count > 8) {
		_shake = argument[8];
	} 

	var wind = 1.00;
	if (argument_count > 9) {
		wind = argument[9];
	} 

	_image_zscale *= oCamera.image_zscale;

	// compute the amount we move each layer by
	// default direction is up (90*), and from there we want the opposite of the camera angle
	var _x_step = oCamera.x_step * _image_zscale;
	var _y_step = oCamera.y_step * _image_zscale;
	var _z_step = oCamera.z_step;
	var _z_height = sprite_get_number(_sprite_index);

	// loop through each slice of the sprite, moving by x and y step each time
	for (var i = 0; i < _z_height; i += _z_step) {
		draw_sprite_ext(_sprite_index, i, _x - _x_step * (i+_z) + random_range(-_shake, _shake), _y - _y_step * (i+_z) + random_range(-_shake, _shake), _image_xscale, _image_yscale, _image_angle + dsin(current_time * 0.2 + i * 2) * wind, image_blend, 1.0);
	}


}
