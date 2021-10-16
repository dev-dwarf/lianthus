///@desc get_data
///@param id
///@param default
function get_data(argument0, argument1) {

	var _id = argument0;
	var _default = argument1;

	var _value = global.save_data[? _id];

	if is_undefined(_value) {
		global.save_data[? _id] = _default;
		ds_map_secure_save(global.save_data, SAVEFILE);
	
		_value = get_data(_id, _default);
	}

	return _value;
}
