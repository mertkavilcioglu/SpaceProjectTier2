shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;
uniform vec2 center;
uniform float force;
uniform float size;
uniform float thickness;

void fragment() {
	float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	vec2 scaledUV = (SCREEN_UV - vec2(0.5, 0.0)) / vec2(ratio, 1.0) + vec2(0.5, 0.0);
	float mask = (1.0 - smoothstep(size-thickness, size, length(scaledUV - center))) *
	smoothstep(size-thickness-0.1, size-thickness, length(scaledUV - center));
	vec2 disp = normalize(scaledUV - center) * force * mask;
	COLOR = texture(screen_texture, SCREEN_UV - disp);
	//COLOR.rgb = vec3(mask);
}
