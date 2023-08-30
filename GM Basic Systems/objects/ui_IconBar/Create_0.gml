icon_xoffset = 0;
icon_yoffset = 0;

switch (fill_direction) {
    case "right":
        icon_xoffset = sprite_get_width(fill_sprite) + icon_gap;
        break;
    case "up":
        icon_yoffset = -sprite_get_height(fill_sprite) - icon_gap;
        break;
    case "left":
        icon_xoffset = -sprite_get_width(fill_sprite) - icon_gap;
        break;
    case "down":
        icon_yoffset = sprite_get_height(fill_sprite) + icon_gap;
        break;
}

// choose the drawing method based on the fill mode
fill_steps = sprite_get_number(fill_sprite);
empty_steps = !is_undefined(empty_sprite) ? sprite_get_number(empty_sprite) : 0;

if (is_undefined(empty_sprite)) {
    // don't draw empty icons at all
    draw_icon = function(_fill_rate, _max_rate, _x, _y) {
        var _img = round(_fill_rate * fill_steps) - 1;
        if (_img >= 0)
            draw_sprite(fill_sprite, _img, _x, _y);
    }
} else if (fill_mode == "replace") {
    // don't draw empty icons if the given icon is full
    draw_icon = function(_fill_rate, _max_rate, _x, _y) {
        var _img = round(_fill_rate * fill_steps) - 1;
        
        if (_img < fill_steps - 1) {
            var _max_img = round(_max_rate * empty_steps);
            draw_sprite(empty_sprite, _max_img, _x, _y);
        }
        
        if (_img >= 0)
            draw_sprite(fill_sprite, _img, _x, _y);
    }
} else if (fill_mode == "stack") {
    // draw empty icons, then the fill icons on top
    draw_icon = function(_fill_rate, _max_rate, _x, _y) {
        var _max_img = round(_max_rate * empty_steps);
        draw_sprite(empty_sprite, _max_img, _x, _y);
        
        var _img = round(_fill_rate * fill_steps) - 1;
        if (_img >= 0)
            draw_sprite(fill_sprite, _img, _x, _y);
    }
}
