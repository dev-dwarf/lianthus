//
// Simple passthrough fragment shader
// optimizes drawing by removing most components
//
varying vec2 v_vTexcoord;

void main()
{
    gl_FragColor = texture2D( gm_BaseTexture, v_vTexcoord);
}
