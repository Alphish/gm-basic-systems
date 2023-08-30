var _value = binding_resolve(value);
var _max_value = binding_resolve(max_value);

var _x = x;
var _y = y;

for (var i = 0; i < max_value; i += icon_value) {
    var _fill_rate = clamp(_value - i, 0, icon_value) / icon_value;
    var _max_rate = clamp(max_value - i, 0, icon_value) / icon_value;
    draw_icon(_fill_rate, _max_rate, _x, _y);
    
    _x += icon_xoffset;
    _y += icon_yoffset;
}
