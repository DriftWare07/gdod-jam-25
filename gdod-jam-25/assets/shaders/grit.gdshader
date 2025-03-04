shader_type canvas_item;
uniform sampler2D color_palette;
uniform bool use_color_reference;
uniform sampler2D color_reference;
uniform sampler2D noise;
uniform float angle;
uniform float dist;
uniform float addititive_intensity;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

void fragment(){
	vec2 noise_offset_r = vec2(sin(angle)*dist, cos(angle)*dist);
	vec2 noise_offset_g = vec2(sin(angle+3.14*0.66)*dist, cos(angle+3.14*0.66)*dist);
	vec2 noise_offset_b = vec2(sin(angle-3.14*0.66)*dist, cos(angle-3.14*0.66)*dist);

	float mindiff = 10.0;
	vec3 adjust = vec3(0.3,0.59,0.11);
	vec3 c = textureLod( SCREEN_TEXTURE, SCREEN_UV, 0.0).rgb;
	c.r += (texture(noise, UV+noise_offset_r).r-0.5) * addititive_intensity;
	c.g += (texture(noise, UV+noise_offset_g).g-0.5) * addititive_intensity;
	c.b += (texture(noise, UV+noise_offset_b).b-0.5) * addititive_intensity;



	vec3 shadow_treshold = texture(TEXTURE, UV, 0.0).rgb;
	vec3 color = vec3(1);
	int colors_in_palette = textureSize(color_palette, 0).x;
	if (use_color_reference){
		for (int i = 0; i < colors_in_palette; i++){
			vec3 reference = texture(color_reference, vec2(1.0/float(colors_in_palette)*(float(i) + 0.5) ,0.5)).rgb;
			vec3 lookup = texture(color_palette, vec2(1.0/float(colors_in_palette)*(float(i) + 0.5) ,0.5)).rgb;
			if (length((reference-c)*adjust) < mindiff){
				color = lookup;
				mindiff = length((reference-c)*adjust);
			}
		}
	}else{
		for (int i = 0; i < colors_in_palette; i++){
			vec3 lookup = texture(color_palette, vec2(1.0/float(colors_in_palette)*(float(i) + 0.5) ,0.5)).rgb;
			if (length((lookup-c)*adjust) < mindiff){
				color = lookup;
				mindiff = length((lookup-c)*adjust);
			}
		}
	}

	COLOR.rgb = color;
}