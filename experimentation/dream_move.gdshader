shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform int pix_size = 4;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 ic = texture(screen_texture, SCREEN_UV);
	float screen_x = 1.0/SCREEN_PIXEL_SIZE.x;
	float screen_y = 1.0/SCREEN_PIXEL_SIZE.y;
	int pixel_size = pix_size*int(screen_x/200.0);
	float x = float(SCREEN_UV.x*screen_x);
	float y = float(SCREEN_UV.y*screen_y);
	ic = texture(screen_texture, vec2((x+sin(y/50.0+TIME*2.0))/screen_x, (y+sin(x/50.0+TIME*2.2))/screen_y));
	COLOR.rgb = ic.rgb;//textureLod(screen_texture, SCREEN_UV, 0.0).rgb;
}