shader_type canvas_item;

// A property of the SDF.
const float pxrange = 2.0;

float screenPxRange(sampler2D msdf, vec2 uv) {
    vec2 unitRange = vec2(pxrange)/vec2(textureSize(msdf, 0));
    vec2 screenTexSize = vec2(1.0)/fwidth(uv);
    return max(0.5*dot(unitRange, screenTexSize), 1.0);
}

float median(float a, float b, float c) {
	return max(min(a, b), min(max(a, b), c));
}

void fragment() {
	vec3 rgb = texture(TEXTURE, UV).xyz;

	float sdf = median(rgb.x, rgb.y, rgb.z);
	sdf -= 0.5;
	sdf *= screenPxRange(TEXTURE, UV);
	sdf = clamp(sdf + 0.5, 0.0, 1.0);
	
	COLOR.rgb = vec3(0.0);
	COLOR.a = sdf;
}