/// @func ValueBinding(readonly)
/// @desc A base structure for value bindings, providing getting and setting logic.
/// @arg {Bool} readonly        Whether the binding value can only be read, or if it can be written too.
function ValueBinding(_readonly) constructor {
    /// @ignore
    is_readonly = _readonly;
    /// @ignore
    current_value = undefined;
    
    when_changed = new EventSubject();
    
    /// @func get_value()
    /// @desc Gets the current value from the binding.
    /// @returns {Any}
    static get_value = function() {
        return inner_get();
    }
    
    /// @func set_value(value)
    /// @desc Sets the bound value.
    /// @arg {Any} value        The value to set.
    static set_value = function(_value) {
        if (is_readonly)
            throw "Cannot set value of a readonly property.";
        
        inner_set(_value);
        current_value = inner_get();
        if (current_value != _value)
            when_changed.send(current_value);
    }
    
    /// @func check_value()
    /// @desc Checks if the current value is up to date, and if not, send a value changed notification.
    static check_value = function() {
        var _value = inner_get();
        if (_value != current_value) {
            current_value = _value;
            when_changed.send(current_value);
        }
    }
    
    /// @ignore
    static inner_get = function() {
        throw $"{instanceof(self)}.inner_get() is not implemented.";
    }
    
    /// @ignore
    static inner_set = function(_value) {
        throw $"{instanceof(self)}.inner_set(value) is not implemented.";
    }
}
