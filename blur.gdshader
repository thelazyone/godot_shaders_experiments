shader_type canvas_item;

uniform sampler2D screen : hint_screen_texture;

void fragment() {
	vec3 col = texture(screen, SCREEN_UV).rgb;
	col += texture(screen, vec2(SCREEN_UV.x - SCREEN_PIXEL_SIZE.x, SCREEN_UV.y)).rgb;
	col += texture(screen, vec2(SCREEN_UV.x + SCREEN_PIXEL_SIZE.x, SCREEN_UV.y)).rgb;
	col += texture(screen, vec2(SCREEN_UV.x, SCREEN_UV.y - SCREEN_PIXEL_SIZE.y)).rgb;
	col += texture(screen, vec2(SCREEN_UV.x, SCREEN_UV.y + SCREEN_PIXEL_SIZE.y)).rgb;
	col *= 0.2;
	COLOR = vec4(col, 1.0);
}