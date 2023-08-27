draw_set_color(c_white);
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);

draw_text(room_width div 2, room_height - 64, summary.get_value());
