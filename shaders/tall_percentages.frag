precision highp float;

varying vec2 f_src_pos;
uniform vec2 u_dst_size;

uniform sampler2D u_texture;

// ==== THRESHOLD ====
const float threshold = 0.01;

// ==== SRC COLORS ====
const vec3 blockentities    = vec3(0.914, 0.427, 0.302);        // #E96D4D
const vec3 unspecified      = vec3(0.271, 0.796, 0.396);        // #45CB65

// ==== DST COLORS ====
const vec4 output_color     = vec4(0.529, 0.463, 0.396, 1.000); // #877665

// ==== SHADOWS ====
const vec4 shadow_color     = vec4(0.800, 0.800, 0.800, 1.000); // #CCCCCC
const float shadow_px = 7.0;


void main() {
    vec4 color = texture2D(u_texture, f_src_pos);

    bool is_blockentities = all(lessThan(abs(color.rgb - blockentities), vec3(threshold)));
    bool is_unspecified = all(lessThan(abs(color.rgb - unspecified), vec3(threshold)));


    vec2 shadow_offset = vec2(
            shadow_px / u_dst_size.x,
            shadow_px / u_dst_size.y / 75.0
            );
    vec4 shadow_src = texture2D(u_texture, f_src_pos - shadow_offset);

    bool is_blockentities_s = all(lessThan(abs(shadow_src.rgb - blockentities), vec3(threshold)));
    bool is_unspecified_s = all(lessThan(abs(shadow_src.rgb - unspecified), vec3(threshold)));


    if ( is_blockentities || is_unspecified ) {
        gl_FragColor = output_color;
    }
    else if ( is_blockentities_s || is_unspecified_s ) {
        gl_FragColor = shadow_color;
    }
    else {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
    }
}

// vim:ft=glsl
