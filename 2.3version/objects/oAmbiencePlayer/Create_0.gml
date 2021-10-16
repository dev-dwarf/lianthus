/// @description

switch room {
	case rShrine: 
	case rField:
	case rForest:
	case rDog:
	case rWitch:
	case rFlats:
	case rEast:
	case rNorth:
	case rPath:
	case rEnd:
		snd = musLightWorld;
	break;
	
	case rShrineDark: 
	case rWitchDark:
	case rFieldDark:
	case rForestDark:
	case rDogDark:
	case rFlatsDark:
	case rEastDark:
	case rNorthDark:
	case rPathDark:
	case rEndDark:

		snd = musDarkWorld;
	break;
	
	case rTitle:
		snd = choose(musLightWorld, musDarkWorld);
	break;
	
	default:
		snd = sndPlayerHurt;
	break;
}

if (room == rDogDark and instance_exists(oDog)) {
	snd = musDogFight;
}

if (room == rShrineDark and instance_exists(oShadow)) {
	snd = musShadowFight;
}


if (global.music_index != snd) {
	audio_sound_gain(global.music_id, 0, 1000)
	
	if !global.dark[room] {
	//	play_sound(musDarkWorldIntro, 0, false, 1.0, 0, music_volume);
		alarm[0] = 1.25 * 60;
	} else {
	//	play_sound(musLightWorldIntro, 0, false, 1.0, 0, music_volume);
		alarm[0] = 1.25 * 60;
	}
	
}

//audio_sound_gain(global.music_id, music_volume, 2000);
