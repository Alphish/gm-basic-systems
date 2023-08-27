/// feather ignore GM2043

/// @func CompositeBinding(calculation,bindings)
/// @desc A value binding that collects values from other bindings and calculates a new value from them.
/// @arg {Function} calculation     The function that processes the bound values.
/// @arg {Any} bindings             The bindings that provide the values for calculations.
function CompositeBinding(_calculation, _bindings) : ValueBinding(true) constructor {
    if (is_undefined(_calculation))
        return;
    
    /// @ignore
    calculation = _calculation;
    /// @ignore
    bindings = _bindings;
    /// @ignore
    binding_subs = [];
    
    link_bindings();
    
    var _input = prepare_input();
    current_value = calculation(_input);
    
    /// @func create(calculation,bindings)
    /// @desc Creates a binding that collects values from other bindings and calculates a new value from them.
    /// @arg {Function} calculation     The function that processes the bound values.
    /// @arg {Any} bindings             The bindings that provide the values for calculations.
    /// @returns {Struct.CompositeBinding}
    static create = function(_calculation, _bindings) {
        return new CompositeBinding(_calculation, _bindings);
    }
    
    /// subscribe to value changes of bindings that provide their values
    /// @ignore
    static link_bindings = function() {
        if (is_instanceof(bindings, ValueBinding)) {
            var _sub = bindings.when_changed.subscribe(self, self.check_value);
            array_push(binding_subs, _sub);
        } else if (is_array(bindings)) {
            array_foreach(bindings, method(self, function(_binding) {
                if (!is_instanceof(_binding, ValueBinding))
                    return;
                
                var _sub = _binding.when_changed.subscribe(self, self.check_value);
                array_push(binding_subs, _sub);
            }));
        } else if (is_struct(bindings)) {
            struct_foreach(bindings, method(self, function(_key, _binding) {
                if (!is_instanceof(_binding, ValueBinding))
                    return;
                
                var _sub = _binding.when_changed.subscribe(self, self.check_value);
                array_push(binding_subs, _sub);
            }));
        }
    }
    
    /// @func check_value()
    /// @desc Recalculates the current value, and sends a value changed event if it's different.
    static check_value = function() {
        var _input = prepare_input();
        var _value = calculation(_input);
        if (_value != current_value) {
            current_value = _value;
            when_changed.send(current_value);
        }
    }
    
    /// @ignore
    static inner_get = function() {
        return current_value;
    }
    
    /// @ignore
    static prepare_input = function() {
        if (is_instanceof(bindings, ValueBinding)) {
            return bindings.get_value();
        } else if (is_array(bindings)) {
            return array_map(bindings, binding_resolve);
        } else if (is_struct(bindings)) {
            var _result = {};
            struct_foreach(bindings, method(_result, function(_key, _binding) {
                self[$ _key] = binding_resolve(_binding);
            }));
            return _result;
        } else {
            return bindings;
        }
    }
    
    /// @func cleanup()
    /// @desc Cleans up all the calculation-related subscriptions.
    static cleanup = function() {
        array_foreach(binding_subs, function(_sub) {
            _sub.unsubscribe();
        });
    }
}

// initialising static properties
var _base_dummy = new ValueBinding(false);
var _dummy = new CompositeBinding(undefined, undefined);
