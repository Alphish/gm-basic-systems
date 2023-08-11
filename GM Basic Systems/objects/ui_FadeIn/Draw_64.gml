draw_set_color(color);
draw_set_alpha(1 - (timer / duration));
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

draw_set_color(c_white);
draw_set_alpha(1);
