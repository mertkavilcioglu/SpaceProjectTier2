shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

uniform vec2 center;
uniform float force;
void fragment() {
	float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	vec2 scaledUV = (SCREEN_UV - vec2(0.5,0.0)) / vec2(ratio, 1.0) + vec2(0.5, 0.0);
	vec2 disp = normalize(scaledUV - center) * force;
	COLOR = texture(screen_texture, SCREEN_UV - disp);
}

