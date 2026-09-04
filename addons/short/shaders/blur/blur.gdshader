shader_type canvas_item;

// Sample the screen.
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
// How much to blur.
uniform float blur_amount: hint_range(0.0, 5.0, 0.05) = 0.0;
// A solid color.
uniform vec4 solid_color: source_color = vec4(1.0, 1.0, 1.0, 1.0);
// Blend result with the solid color this much.
uniform float solid_blend: hint_range(0.0, 1.0, 0.05) = 0.0;

// Called for every pixel the material is visible on.
void fragment() {
	vec3 blur_result = textureLod(SCREEN_TEXTURE, SCREEN_UV, blur_amount).rgb;
	vec3 blend_result = mix(blur_result, solid_color.rgb, solid_blend);
	COLOR.rgb = blend_result;
}