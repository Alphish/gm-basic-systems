/// feather ignore GM2043

/// @func CompositeBinding(bindings,calculation)
/// @desc A value binding that collects values from other bindings and calculates a new value from them.
/// @arg {Any} bindings             The bindings that provide the values for calculations.
/// @arg {Function} calculation     The function that processes the bound values.
function CompositeBinding(_bindings, _calculation) : ValueBinding(true) constructor {
    if (is_undefined(_bindings))
        return;
    
    if (!is_array(_bindings) && (!is_struct(_bindings) || is_instanceof(_bindings, ValueBinding)))
        throw "The composite binding must provide an array or a struct of bindings to provide their input.";
    
    /// @ignore
    bindings = _bindings;
    /// @ignore
    binding_subs = [];
    link_bindings();
    /// @ignore
    calculation = _calculation;
    
    /// @ignore
    current_value = get_underlying();
    
    /// @func create(calculation,bindings)
    /// @desc Creates a binding that collects values from other bindings and calculates a new value from them.
    /// @arg {Any} bindings             The bindings that provide the values for calculations.
    /// @arg {Function} calculation     The function that processes the bound values.
    /// @returns {Struct.CompositeBinding}
    static create = function(_bindings, _calculation) {
        return new CompositeBinding(_bindings, _calculation);
    }
    
    /// subscribe to value changes of bindings that provide their values
    /// @ignore
    static link_bindings = function() {
        if (is_array(bindings)) {
            array_foreach(bindings, method(self, function(_binding) {
                if (!is_instanceof(_binding, ValueBinding))
                    return;
                
                var _sub = _binding.when_changed.subscribe(self, self.check_value);
                array_push(binding_subs, _sub);
            }));
        } else {
            struct_foreach(bindings, method(self, function(_key, _binding) {
                if (!is_instanceof(_binding, ValueBinding))
                    return;
                
                var _sub = _binding.when_changed.subscribe(self, self.check_value);
                array_push(binding_subs, _sub);
            }));
        }
    }

    /// @ignore
    static get_underlying = function() {
        var _input = prepare_input();
        return calculation(_input);
    }
    
    /// @ignore
    static prepare_input = function() {
        if (is_array(bindings)) {
            return array_map(bindings, binding_resolve);
        } else {
            var _result = {};
            struct_foreach(bindings, method(_result, function(_key, _binding) {
                self[$ _key] = binding_resolve(_binding);
            }));
            return _result;
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
