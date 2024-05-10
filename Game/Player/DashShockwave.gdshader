shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

uniform vec2 hunter_position; // Objemizin dünya konumu
uniform float force;
uniform float size;
uniform float thickness;

void fragment() {
    vec2 scaledUV = (SCREEN_UV - vec2(0.5,0.0)) / vec2(SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y, 1.0) + vec2(0.5, 0.0);
    
    // Objemizin konumuna göre yer değiştirme vektörünü hesaplayalım
    vec2 hunterUV = (hunter_position.xy / vec2(SCREEN_PIXEL_SIZE.x, SCREEN_PIXEL_SIZE.y));
    float distanceToHunter = length(SCREEN_UV - hunterUV);
    float mask = (1.0 - smoothstep(size-0.1, size, distanceToHunter)) * 
                 smoothstep(size-thickness-0.1, size-thickness, distanceToHunter);
    vec2 disp = normalize(SCREEN_UV - hunterUV) * force * mask;

    COLOR = texture(screen_texture, SCREEN_UV - disp);
}
