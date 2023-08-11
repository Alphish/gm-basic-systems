/// @func TransitionBuilder()
/// @desc A builder for configuring a transition to perform.
function TransitionBuilder() constructor {
    // reusable empty struct, please do not add stuff to it
    /// @ignore
    static empty_vars = {};
    
    /// @ignore
    transition_room = undefined;
    /// @ignore
    transition_data = undefined;
    /// @ignore
    fade_out_action = undefined;
    /// @ignore
    fade_in_action = undefined;

    /// @ignore
    fade_out_object = sys_Transition.default_fade_out_object;
    /// @ignore
    fade_out_vars = sys_Transition.default_fade_out_vars ?? empty_vars;
    /// @ignore
    fade_in_object = sys_Transition.default_fade_in_object;
    /// @ignore
    fade_in_vars = sys_Transition.default_fade_in_vars ?? empty_vars;
    
    /// @func entering_room(room)
    /// @desc Sets a room to enter after the fade out completes.
    /// @arg {Asset.GMRoom} room        The room to enter.
    /// @returns {Struct.TransitionBuilder}
    static entering_room = function(_room) {
        transition_room = _room;
        return self;
    }
    
    /// @func restarting_room()
    /// @desc Prepares restarting a room after the fade out completes.
    /// @returns {Struct.TransitionBuilder}
    static restarting_room = function() {
        transition_room = room;
        return self;
    }
    
    /// @func with_data(data)
    /// @desc Stores the data to use during or after the transition.
    /// @arg {Any} data             The data to store.
    /// @returns {Struct.TransitionBuilder}
    static with_data = function(_data) {
        transition_data = _data;
        return self;
    }
    
    /// @func on_fade_out(action)
    /// @desc Prepares a function to execute just after the fade out finishes, but before changing the room (if applicable).
    /// @arg {Function} action      The function to execute.
    /// @returns {Struct.TransitionBuilder}
    static on_fade_out = function(_action) {
        fade_out_action = _action;
        return self;
    }
    
    /// @func on_fade_in(action)
    /// @desc Prepares a function to execute just before the fade in begins, after changing the room (if applicable).
    /// @arg {Function} action      The function to execute.
    /// @returns {Struct.TransitionBuilder}
    static on_fade_in = function(_action) {
        fade_in_action = _action;
        return self;
    }
    
    /// @func with_fade_out_object(object,[vars])
    /// @desc Sets the fade out object to create, along with its initial variables (if any).
    /// @arg {Asset.GMObject} object        The fade out object to create.
    /// @arg {Struct} [vars]                The variables to create the new object with.
    /// @returns {Struct.TransitionBuilder}
    static with_fade_out_object = function(_object, _vars = undefined) {
        fade_out_object = _object;
        fade_out_vars = _vars ?? empty_vars;
        return self;
    }
    
    /// @func with_fade_in_object(object,[vars])
    /// @desc Sets the fade in object to create, along with its initial variables (if any).
    /// @arg {Asset.GMObject} object        The fade in object to create.
    /// @arg {Struct} [vars]                The variables to create the new object with.
    /// @returns {Struct.TransitionBuilder}
    static with_fade_in_object = function(_object, _vars = undefined) {
        fade_in_object = _object;
        fade_in_vars = _vars ?? empty_vars;
        return self;
    }
    
    /// @func perform()
    /// @desc Immediately begins the corresponding transition.
    static perform = function() {
        sys_Transition.begin_transition();
    }
}
