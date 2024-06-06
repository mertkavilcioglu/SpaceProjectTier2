shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;
uniform float ca_strength = 20.0;

void fragment() {
	vec2 ca_offset = vec2(ca_strength, 0.0) * SCREEN_PIXEL_SIZE;
	
	float red = texture(screen_texture, SCREEN_UV - ca_offset).r;
	float green = texture(screen_texture, SCREEN_UV).g;
	float blue = texture(screen_texture, SCREEN_UV + ca_offset).b;
	
	COLOR = vec4(red, green, blue, 1.0);
}

