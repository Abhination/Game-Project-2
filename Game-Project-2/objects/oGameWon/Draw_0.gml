/// @description Insert description here
// You can write your code in this editor

shader_set(sRainbow);
shader_set_uniform_f(uni_time, current_time/1000);
draw_self();
shader_reset();