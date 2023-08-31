draw_self();

draw_set_color(image_blend);
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x + sprite_width div 2, y + sprite_height div 2, is_undefined(bgm_name) ? "Play nothing" : "Play [" + bgm_name + "]");

draw_set_color(c_white);
