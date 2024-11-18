shader_type canvas_item;

uniform float dissolve_value : hint_range(-0.3,1.3);
uniform vec3 color: source_color;
uniform sampler2D dissolve_texture;

void fragment(){
    vec4 main_texture = texture(TEXTURE, UV);
    vec4 noise_texture = texture(dissolve_texture, UV);
    main_texture.a *= floor(dissolve_value + min(1, noise_texture.x));
    COLOR = main_texture;
}