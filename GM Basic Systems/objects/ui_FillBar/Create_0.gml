is_horizontal = fill_direction == "right" || fill_direction == "left";
is_vertical = !is_horizontal;

// choosing the progress drawing functions depending on the fill direction
switch (fill_direction) {
    case "right":
        draw_fill_progress = function(_sprite, _image, _progress, _x, _y) {
            var _thickness = sprite_get_height(_sprite);
            draw_sprite_part(_sprite, _image, 0, 0, _progress, _thickness, _x, _y);
        }
        draw_counter_progress = function(_sprite, _image, _progress, _x, _y) {
            var _thickness = sprite_get_height(_sprite);
            var _counter_progress = sprite_get_width(_sprite) - _progress;
            draw_sprite_part(_sprite, _image, _progress, 0, _counter_progress, _thickness, _x + _progress, _y);
        }
        break;
    
    case "up":
        draw_fill_progress = function(_sprite, _image, _progress, _x, _y) {
            var _thickness = sprite_get_width(_sprite);
            var _offset = sprite_get_height(_sprite) - _progress;
            draw_sprite_part(_sprite, _image, 0, _offset, _thickness, _progress, _x, _y + _offset);
        }
        draw_counter_progress = function(_sprite, _image, _progress, _x, _y) {
            var _thickness = sprite_get_width(_sprite);
            var _counter_progress = sprite_get_height(_sprite) - _progress;
            draw_sprite_part(_sprite, _image, 0, 0, _thickness, _counter_progress, _x, _y);
        }
        break;
    
    case "left":
        draw_fill_progress = function(_sprite, _image, _progress, _x, _y) {
            var _thickness = sprite_get_height(_sprite);
            var _offset = sprite_get_width(_sprite) - _progress;
            draw_sprite_part(_sprite, _image, _offset, 0, _progress, _thickness, _x + _offset, _y);
        }
        draw_counter_progress = function(_sprite, _image, _progress, _x, _y) {
            var _thickness = sprite_get_height(_sprite);
            var _counter_progress = sprite_get_width(_sprite) - _progress;
            draw_sprite_part(_sprite, _image, 0, 0, _counter_progress, _thickness, _x, _y);
        }
        break;
    
    case "down":
        draw_fill_progress = function(_sprite, _image, _progress, _x, _y) {
            var _thickness = sprite_get_width(_sprite);
            draw_sprite_part(_sprite, _image, 0, 0, _thickness, _progress, _x, _y);
        }
        draw_counter_progress = function(_sprite, _image, _progress, _x, _y) {
            var _thickness = sprite_get_width(_sprite);
            var _counter_progress = sprite_get_height(_sprite) - _progress;
            draw_sprite_part(_sprite, _image, 0, _progress, _thickness, _counter_progress, _x, _y + _progress);
        }
        break;
}
