/// approach(start, ending, difference);
function approach(argument0, argument1, argument2) {
	var start, ending, difference;
 
	start = argument0;
	ending = argument1;
	difference = argument2;
 
	var result;
 
	if (start < ending){
	    result = min(start + difference, ending);
	}else{
	    result = max(start - difference, ending);
	}
 
	return result;


}
