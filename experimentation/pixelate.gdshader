shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform int pix_size = 4;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 ic = texture(screen_texture, SCREEN_UV)/vec4(2);
	float screen_x = 1.0/SCREEN_PIXEL_SIZE.x;
	float screen_y = 1.0/SCREEN_PIXEL_SIZE.y;
	int pixel_size = pix_size*int(screen_x/400.0);
	int x = int(SCREEN_UV.x*screen_x);
	int y = int(SCREEN_UV.y*screen_y);
	ic = texture(screen_texture, vec2(float(x-(x%pixel_size))/screen_x, float(y-(y%pixel_size))/screen_y));
	COLOR.rgb = ic.rgb;//textureLod(screen_texture, SCREEN_UV, 0.0).rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
