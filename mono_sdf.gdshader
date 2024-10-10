shader_type canvas_item;

uniform float bias;
uniform float stroke;

// A property of the SDF.
const float pxrange = 4.0;

float screenPxRange(sampler2D msdf, vec2 uv) {
    vec2 unitRange = vec2(pxrange)/vec2(textureSize(msdf, 0));
    vec2 screenTexSize = vec2(1.0)/fwidth(uv);
    return max(0.5*dot(unitRange, screenTexSize), 1.0);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float sdf = texture(TEXTURE, UV).r + bias;
	float sdf2 = 0.0;
	if(sdf > 0.5) {
		sdf2 = 1.0;
	}

	sdf -= 0.5;
	sdf *= screenPxRange(TEXTURE, UV);
	sdf = clamp(sdf + 0.5, 0.0, 1.0);

	//float step_range = 1.0 / screenPxRange(TEXTURE, UV); //dot(fwidth(UV), 1.0 / TEXTURE_PIXEL_SIZE) * 0.5;

	// Field is centered around 0.5
	//sdf -= 0.5;
	//float color = 0.0;
	//if(sdf < stroke) {
	//	color = 1.0;
	//}
	// Clamp to the appropriate range
	//sdf = clamp(sdf, -step_range * 0.5, step_range * 0.5);
	// Rescale to 0-1
	//sdf = (sdf / step_range) + 0.5;



	//float alpha = (sdf >= 0.5) ? 1.0 : 0.0;
	//COLOR.rgb = vec3(color);
	COLOR.rgb = vec3(0.0);
	COLOR.a = sdf;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
