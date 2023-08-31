draw_self();

draw_set_color(image_blend);
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _name = is_string(sfx_name) ? sfx_name : audio_get_name(sfx_name);
draw_text(x + sprite_width div 2, y + sprite_height div 2, "Play [" + _name + "]");

draw_set_color(c_white);
