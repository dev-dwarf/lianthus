/// @description
//switch async_load[? "event_type"] {
//	case "gamepad discovered":
//		global.gamepad_connected = true;
//		global.gamepad_slot = async_load[? "pad_index"];
//		global.gamepad_is_xbox = (global.gamepad_slot < 4)
//		//log("gamepad connected: " + string(global.gamepad_slot));
//	break;
//	case "gamepad lost":
//		global.gamepad_connected = false;
//		global.gamepad_slot = 0;
//		//log("gamepad lost");
//	break;
//}