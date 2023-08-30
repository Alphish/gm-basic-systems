/// feather ignore GM2043

/// @func DescriptionBinding(format,bindings)
/// @desc A binding that provides a formatted string using values from the given bindings.
/// @arg {String} format                    The format of the generated descriptions.
/// @arg {Array<Struct.ValueBinding>}       The bindings providing the values to the description.
function DescriptionBinding(_format, _bindings) : ValueBinding(true) constructor {
    if (is_undefined(_format))
        return;
    
    if (!is_string(_format))
        throw "A desription binding must be passed a string as a format.";
    
    if (!is_array(_bindings))
        throw "A description binding must be passed an array as its collection of bindings.";
    
    /// @ignore
    format = _format;
    /// @ignore
    bindings = _bindings;
    /// @ignore
    binding_subs = [];
    link_bindings();
    
    /// @ignore
    current_value = get_underlying();
    
    /// @func from_args(format,[...bindings])
    /// @desc Creates a description binding for a given format and bindings provided as arguments.
    /// @arg {String} format            The format of the generated descriptions.
    /// @arg Struct.ValueBinding        The bindings providing the values to the description.
    /// @returns {Struct.DescriptionBinding}
    static from_args = function(_format) {
        var _bindings = [];
        for (var i = 1; i < argument_count; i++) {
            array_push(_bindings, argument[i]);
        }
        return new DescriptionBinding(_format, _bindings);
    }
    
    /// @func from_array(format,bindings)
    /// @desc Creates a description binding for a given format and an array of bindings.
    /// @arg {String} format                    The format of the generated descriptions.
    /// @arg {Array<Struct.ValueBinding>}       The bindings providing the values to the description.
    /// @returns {Struct.DescriptionBinding}
    static from_array = function(_format, _bindings) {
        return new DescriptionBinding(_format, _bindings);
    }
    
    /// @ignore
    static link_bindings = function() {
        array_foreach(bindings, method(self, function(_binding) {
            if (!is_instanceof(_binding, ValueBinding))
                return;
                
            var _sub = _binding.when_changed.subscribe(self, self.check_value);
            array_push(binding_subs, _sub);
        }));
    }
    
    /// @ignore
    static get_underlying = function() {
        var _input = array_map(bindings, binding_resolve);
        return string_ext(format, _input);
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
/// feather ignore GM1041
var _dummy = new DescriptionBinding(undefined, undefined);
