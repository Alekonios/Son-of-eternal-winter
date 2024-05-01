shader_type spatial;

uniform sampler2D fire_texture;
uniform float speed = 1.0;

void fragment() {
    vec2 uv = UV;
    uv.y += TIME * speed; // Двигаем текстуру по вертикали для создания эффекта пульсации

    vec4 color = texture(fire_texture, uv); // Получаем цвет из текстуры огня

    // Увеличиваем яркость цвета для более яркого эффекта огня
    color.rgb *= 3.5;

    ALBEDO = color.rgb;
    ALPHA = color.a;
}