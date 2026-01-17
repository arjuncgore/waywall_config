precision mediump float;
precision mediump int;

varying vec2 f_src_pos;
uniform sampler2D u_texture;

void main() {
    vec4 color = texture2D(u_texture, f_src_pos);

    vec3 paused = vec3(41.0, 49.0, 68.0) / 255.0;
    vec3 target = vec3(131.0, 168.0, 255.0) / 255.0;

    vec3 scale = target / paused;
    color.rgb *= scale;

    gl_FragColor = color;
}


// vim:ft=glsl
