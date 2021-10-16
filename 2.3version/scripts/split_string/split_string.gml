///@param string
function split_string(argument0) {

	var list = ds_list_create();
	var str = ""; var char = ""

	for (var i = 1; i < string_length(argument0); i++) {
		char = string_char_at(argument0, i);
	
		if (char == " ") {
			ds_list_add(list, str);
			//log(str);
			str = "";
		} else {
			str += char;
		}	
	}

	ds_list_add(list,str); // add last entry

	return list;


}
