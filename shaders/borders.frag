
varying vec2 f_src_pos;

uniform sampler2D u_texture;

// ==== THRESHOLD ====
const float threshold = 0.01;

// ==== SRC COLORS ====
const vec3 ecounter         = vec3(1.0, 1.0, 1.0);        // #FFFFFF


void main() {
    vec4 color = texture2D(u_texture, f_src_pos);

    bool is_border = all(lessThan(abs(color.rgb - ecounter), vec3(threshold)));


    if ( is_border ) {
        gl_FragColor = border_color;
    }
    else {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
    }
}

// vim:ft=glsl
