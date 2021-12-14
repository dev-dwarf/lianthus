varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 color0;
uniform vec3 color1;
uniform vec3 color2;
uniform vec3 color3;
uniform vec3 color4;
uniform vec3 color5;
uniform vec3 color6;
uniform vec3 color7;

void main()
{
    vec4 in_color = texture2D( gm_BaseTexture, v_vTexcoord) * v_vColour;
	vec3 source = in_color.rgb;
    
	if (source.rgb == vec3( 035./255., 012./255., 069./255.)) {
		source = color0;	 
	} else					 
	if (source.rgb == vec3( 000./255., 077./255., 087./255.)) {
		source = color1;	  
	} else					  
	if (source.rgb == vec3( 150./255., 083./255., 029./255.)) {
		source = color2;	  
	} else					  
	if (source.rgb == vec3( 255./255., 207./255., 000./255.)) {
		source = color3;	
	} else					
	if (source.rgb == vec3( 255./255., 255./255., 247./255.)) {
		source = color4;	
	} else					
	if (source.rgb == vec3( 255./255., 000./255., 089./255.)) {
		source = color5;	
	} else					
	if (source.rgb == vec3( 010./255., 003./255., 013./255.)) {
		source = color6;
	} else					
	if (source.rgb == vec3( 121./255., 115./255., 102./255.)) {
		source = color7;
	}
	
    gl_FragColor = vec4(source, in_color.a);
}