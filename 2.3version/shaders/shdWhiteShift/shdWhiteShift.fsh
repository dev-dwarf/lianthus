varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//uniform float shift;

void main()
{
    vec4 in_color = texture2D( gm_BaseTexture, v_vTexcoord) * v_vColour;
	vec3 source = in_color.rgb;
	
   // if (v_vTexcoord.y <= shift) {
		if (source.rgb == vec3( 255./255., 000./255., 089./255.)) {
			source = vec3( 255./255., 255./255., 247./255.);	 
		} else					 				
		if (source.rgb == vec3( 255./255., 255./255., 247./255.)) {
			source = vec3( 255./255., 000./255., 089./255.);	
		}
//	}
	
    gl_FragColor = vec4(source, in_color.a);
}