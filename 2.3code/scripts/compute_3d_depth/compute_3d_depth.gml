///@function compute_3d_depth
///@param x
///@param y
///@param z
function compute_3d_depth() {

	var _x				= argument[0];
	var _y				= argument[1];
	var _z				= argument[2];

	var _depth = _x * dcos(90 + oCamera.angle) +
				 _y * dsin(90 + oCamera.angle) +
				 _z;

	return -1 * _depth;


}
