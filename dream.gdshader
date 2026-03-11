shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 ic = texture(screen_texture, SCREEN_UV);
	float screen_x = 1.0/SCREEN_PIXEL_SIZE.x;
	float screen_y = 1.0/SCREEN_PIXEL_SIZE.y;
	float x = float(SCREEN_UV.x)*300.0;
	float y = float(SCREEN_UV.y)*300.0;
	ic.r -= sin(y*cos(TIME/100.0)/100.0 + (float(x)+TIME*100.0)/70.0)*.5+1.0;
	ic.g -= sin(y*cos(TIME/80.0)/100.0 + (float(x)+TIME*20.0)/200.0)*.5+1.0;
	COLOR.rgb = ic.rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
