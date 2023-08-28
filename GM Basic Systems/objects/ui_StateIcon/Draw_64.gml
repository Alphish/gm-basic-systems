var _state = binding_resolve(state);

var _sprite;
if (is_array(sprites))
    _sprite = sprites[real(_state)];
else if (is_struct(sprites))
    _sprite = sprites[$ string(_state)];
else
    _sprite = sprites;

var _image;
if (is_array(images))
    _image = images[real(_state)];
else if (is_struct(images))
    _image = images[$ string(_state)];
else
    _image = images;

draw_sprite(_sprite, _image, x, y);
