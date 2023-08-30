draw_set_color(binding_resolve(color));
draw_set_alpha(binding_resolve(alpha));

draw_set_halign(halign);
draw_set_valign(valign);
draw_set_font(font);

var _text = string(format, binding_resolve(text));
draw_text(x, y, _text);
