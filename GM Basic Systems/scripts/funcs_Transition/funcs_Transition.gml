/// @func transition_make()
/// @desc Begins building a transition to perform.
/// @returns {Struct.TransitionBuilder}
function transition_make() {
    if (!is_undefined(sys_Transition.pending_transition))
        throw "Another transition has been already prepared.";
    
    if (sys_Transition.fades_out)
        throw "A transition is already in progress.";
    
    sys_Transition.pending_transition = new TransitionBuilder();
    return sys_Transition.pending_transition;
}

/// @func transition_is_leaving()
/// @desc Checks if there is a leaving transition in progress.
/// @returns {Bool}
function transition_is_leaving() {
    return sys_Transition.fades_out;
}

/// @func transition_is_entering()
/// @desc Checks if there is an entering transition in progress.
/// @returns {Bool}
function transition_is_entering() {
    return instance_exists(sys_Transition.fade_in_instance);
}

/// @func transition_get_data()
/// @desc Returns the current transition data.
/// @returns {Any}
function transition_get_data() {
    return sys_Transition.transition_data;
}
