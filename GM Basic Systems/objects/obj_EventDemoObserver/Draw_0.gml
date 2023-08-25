draw_set_color(c_white)

var _cx = x + sprite_width div 2;
var _cy = y + sprite_height div 2;
var _cr = sprite_width div 2;
draw_circle(_cx, _cy, _cr, true);

if (target_subject != noone) {
    var _dir = point_direction(x, y, target_subject.x, target_subject.y);
    draw_circle(_cx + lengthdir_x(_cr / 2, _dir), _cy + lengthdir_y(_cr / 2, _dir), 8, false);
}
