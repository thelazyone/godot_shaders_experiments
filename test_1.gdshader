shader_type canvas_item;

uniform sampler2D screen : hint_screen_texture; // Captures the current screen
uniform vec2 viewport_size; // Set this from your Godot script

void fragment() {
    vec2 uv = FRAGCOORD.xy / viewport_size;
    int live_neighbors = 0;
    vec2 offsets[8] = vec2[](
        vec2(-1, 1), vec2(0, 1), vec2(1, 1),
        vec2(-1, 0),             vec2(1, 0),
        vec2(-1,-1), vec2(0,-1), vec2(1,-1)
    );

    // Calculate pixel size based on the viewport dimensions
    vec2 pixel_size = 1.0 / viewport_size;

    for (int i = 0; i < 8; i++) {
        live_neighbors += int(texture(screen, uv + offsets[i] * pixel_size).r > 0.5);
    }

    float current = texture(screen, uv).r;
    if (current > 0.5) {
        // Cell survival rules
        COLOR = vec4((live_neighbors == 2 || live_neighbors == 3) ? 1.0 : 0.0, 0.0, 0.0, 1.0);
    } else {
        // Cell reproduction rules
        COLOR = vec4((live_neighbors == 3) ? 1.0 : 0.0, 0.0, 0.0, 1.0);
    }
}
