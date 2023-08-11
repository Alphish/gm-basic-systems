#region Variables

transition_room = room;
transition_previous_room = undefined;

transition_data = undefined;
fade_out_action = undefined;
fade_in_action = undefined;

fade_out_object = undefined;
fade_out_vars = undefined;
fade_in_object = initial_fade_in_object;
fade_in_vars = initial_fade_in_vars ?? {};

pending_transition = undefined;
fades_out = false;
fade_out_instance = noone;
fade_in_instance = noone;

#endregion

#region Methods

begin_transition = function() {
    transition_room = pending_transition.transition_room;
    if ((room_exists(transition_room) && transition_room != room) || !is_undefined(pending_transition.transition_data))
        transition_data = pending_transition.transition_data;
    
    fade_out_action = pending_transition.fade_out_action;
    fade_in_action = pending_transition.fade_in_action;
    
    fade_out_object = pending_transition.fade_out_object;
    fade_out_vars = pending_transition.fade_out_vars;
    fade_in_object = pending_transition.fade_in_object;
    fade_in_vars = pending_transition.fade_in_vars;
    
    pending_transition = undefined;
    enter_fade_out();
}

enter_fade_out = function() {
    fades_out = true;
    
    if (!is_undefined(fade_out_object))
        fade_out_instance = instance_create_depth(0, 0, fade_depth, fade_out_object, fade_out_vars);
    else
        leave_fade_out();
}

leave_fade_out = function() {
    if (instance_exists(fade_out_instance))
        instance_destroy(fade_out_instance);
    
    fade_out_instance = noone;
    if (!is_undefined(fade_out_action))
        fade_out_action();
    
    if (transition_room == room) {
        room_restart();
    } else if (room_exists(transition_room)) {
        transition_previous_room = room;
        room_goto(transition_room);
    } else {
        enter_fade_in();
    }
}

enter_fade_in = function() {
    fades_out = false;
    
    if (!is_undefined(fade_in_action))
        fade_in_action();
    
    if (!is_undefined(fade_in_object))
        fade_in_instance = instance_create_depth(0, 0, fade_depth, fade_in_object, fade_in_vars);
    else
        leave_fade_in();
}

leave_fade_in = function() {
    if (instance_exists(fade_in_instance))
        instance_destroy(fade_in_instance);
    
    fade_in_instance = noone;
}

#endregion

#region Startup

if (!is_undefined(fade_in_object))
    enter_fade_in();

#endregion
