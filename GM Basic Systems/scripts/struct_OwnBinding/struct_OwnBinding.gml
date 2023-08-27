/// @func OwnBinding(initial)
/// @desc A standalone binding that stores its own value, without affecting any other values.
/// @arg {Any} initial      The initial value of the binding.
function OwnBinding(_initial) : ValueBinding(false) constructor {
    current_value = _initial;
    
    /// @func create(initial)
    /// @desc Creates a standalone binding that stores its own value.
    /// @arg {Any} initial      The initial value of the binding.
    /// @returns {Struct.OwnBinding}
    static create = function(_initial) {
        return new OwnBinding(_initial);
    }
    
    /// @ignore
    static check_value = function() {
        // no binding update to check
    }
    
    /// @func get_value()
    /// @desc Returns the current value of the binding.
    /// @returns {Any}
    static get_value = function() {
        return current_value;
    }
    
    /// func set_value(value)
    /// @desc Sets the new value to the binding, and sends a value changed event if it's different.
    /// @arg {Any} value        The new value to set.
    static set_value = function(_value) {
        if (current_value == _value)
            return;
        
        current_value = _value;
        when_changed.send(current_value);
    }
}

// initialising static properties
var _base_dummy = new ValueBinding(false);
var _dummy = new OwnBinding(undefined);
