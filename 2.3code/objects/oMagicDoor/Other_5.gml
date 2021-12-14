/// @description
global.save_data[? "doorLocked" + string(room)] = locked;
ds_map_secure_save(global.save_data, SAVEFILE);
global.recently_saved = 180;
