precision highp float;

// Helper for 0..255 RGB(A) to 0..1 vec4
#define RGB8(r,g,b)   (vec4((r)/255.0, (g)/255.0, (b)/255.0, 1.0))
#define RGBA8(r,g,b,a) (vec4((r)/255.0, (g)/255.0, (b)/255.0, (a)/255.0))

// Borders                  = #9FA3B2
// const vec4 border_color  = RGB8(159.0, 163.0, 178.0);
// const vec4 border_color  = RGB8(255.0, 255.0, 255.0);
// const vec4 border_color  = RGB8(0.0, 0.0, 0.0);
const vec4 border_color  = RGB8(255.0, 145.0, 164.0);

// Pie Chart 1              = #3DC9A7
const vec4 pie1_color    = RGB8(61.0, 201.0, 167.0);

// Pie Chart 2              = #E6B057
const vec4 pie2_color    = RGB8(230.0, 176.0, 87.0);

// Pie Chart 3              = #F26B5E
const vec4 pie3_color    = RGB8(242.0, 107.0, 94.0);

// Text                     = #F2F2F7
const vec4 text_color    = RGB8(242.0, 242.0, 247.0);

// Text Background          = #0A0A12
const vec4 text_bg_color = RGB8(10.0, 10.0, 18.0);

