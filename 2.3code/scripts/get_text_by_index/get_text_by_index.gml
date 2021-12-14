///@param index
function get_text_by_index(argument0) {
	//return global.text_grid[# global.text_language, argument0 - 1];
	return string_copy(global.text_grid[# global.text_language, argument0 - 1], 2, string_length(global.text_grid[# global.text_language, argument0 - 1])-2);
}
