shader_type spatial;


uniform sampler2D noise;
uniform sampler2D gradient;

float fresnel(float amount, vec3 normal, vec3 view)
{
	return pow(
		(clamp(dot(normalize(normal), normalize(view)), -1.0, 5.0)),
		amount
	);
}

void fragment() {
	float basic_fresnel = fresnel(2.0, NORMAL, VIEW);
	vec4 pixel = texture(noise, UV * vec2(1, 0.25) + vec2(0, 0.2 * TIME));
	vec4 color = texture(gradient, vec2(UV.y, 0));
	ALBEDO = pixel.rgb * color.rgb;
	ALPHA = 0.0; // Установка ALPHA в 0, чтобы сделать объект полностью прозрачным
}


