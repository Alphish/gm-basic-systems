var _value = binding_resolve(value);
var _min_value = binding_resolve(min_value);
var _max_value = binding_resolve(max_value);
_value = clamp(_value, _min_value, _max_value);

var _fill_mode = binding_resolve(fill_mode);
var _fill_direction = binding_resolve(fill_direction);
var _filled_sprite = binding_resolve(filled_sprite);
var _filled_image = binding_resolve(filled_image);
var _empty_sprite = binding_resolve(empty_sprite) ?? _filled_sprite;
var _empty_image = binding_resolve(empty_image);

// taking care of simple cases
if (_value == _min_value) {
    draw_sprite(_empty_sprite, _empty_image, x, y);
    return;
}

if (_fill_mode == "stack") {
    draw_sprite(_empty_sprite, _empty_image, x, y);
}

if (_value == _max_value) {
    draw_sprite(_filled_sprite, _filled_image, x, y);
    return;
}

// drawing partial bars
var _bar_span = is_horizontal ? sprite_get_width(_filled_sprite) : sprite_get_height(_filled_sprite);
var _fill_span = _bar_span - fill_margin_start - fill_margin_end;
var _value_progress = (_value - _min_value) / (_max_value - _min_value);
var _fill_progress = fill_margin_start + round(_fill_span * _value_progress);

var _leftx = x - sprite_get_xoffset(_filled_sprite);
var _topy = y - sprite_get_yoffset(_filled_sprite);
draw_fill_progress(_filled_sprite, _filled_image, _fill_progress, _leftx, _topy);

if (_fill_mode == "replace")
    draw_counter_progress(_empty_sprite, _empty_image, _fill_progress, _leftx, _topy);
