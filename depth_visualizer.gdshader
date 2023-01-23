shader_type spatial;

render_mode unshaded;

uniform float zNear = 3.0;
uniform float zFar = 1000.0;

void vertex() {
	POSITION = vec4(VERTEX, 1.0);
}

void fragment() {
	vec4 original = texture(SCREEN_TEXTURE, SCREEN_UV);
	float depth = texture(DEPTH_TEXTURE, SCREEN_UV).x;
	vec3 ndc = vec3(SCREEN_UV, depth) * 2.0 - 1.0;
	
	vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
	view.xyz /= view.w;
	
	float linear_depth = view.z;
	float scaled_depth = (zFar * zNear) / (zFar + (linear_depth * (zNear - zFar)));

	vec3 gray = vec3(0.5);
	ALBEDO = mix(gray, original.rgb, scaled_depth);
}
