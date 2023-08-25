if (!is_undefined(subscription))
    subscription.unsubscribe();

var _number = irandom(instance_number(obj_EventDemoSubject) - 1);

with (obj_EventDemoSubject) {
    if (_number == 0) {
        other.target_subject = id;
        other.subscription = subject.subscribe(other.id, function(_data) {
            effect_create_below(_data.effect, x + sprite_width div 2, y + sprite_height div 2, 1, _data.color);
        });
        break;
    }
    _number--;
}
