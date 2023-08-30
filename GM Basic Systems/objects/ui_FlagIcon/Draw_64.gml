var _value = binding_resolve(flag);
var _sprite = _value ? true_sprite : (false_sprite ?? true_sprite);
var _image = _value ? true_image : false_image;
draw_sprite(_sprite, _image, x, y);
