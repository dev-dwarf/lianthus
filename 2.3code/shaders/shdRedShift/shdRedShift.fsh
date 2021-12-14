varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//uniform float shift;

void main()
{
    vec4 in_color = texture2D( gm_BaseTexture, v_vTexcoord) * v_vColour;
	vec3 source = in_color.rgb;
	
   // if (v_vTexcoord.y <= shift) {
		if (source.rgb == vec3( 035./255., 012./255., 069./255.)) {
			source = vec3( 010./255., 003./255., 013./255.);	 
		} else					 				
		if (source.rgb == vec3( 255./255., 255./255., 247./255.)) {
			source = vec3( 255./255., 000./255., 089./255.);	
		}
//	}
	
    gl_FragColor = vec4(source, in_color.a);
}