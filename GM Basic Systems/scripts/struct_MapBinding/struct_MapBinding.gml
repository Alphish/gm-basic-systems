/// feather ignore GM2043

/// @func MapBinding(binding,mapping,mapback)
/// @desc A binding that maps a value from another binding.
/// @arg {Struct.ValueBinding} binding      The source binding to map the value from/to.
/// @arg {Function} mapping                 The function mapping the value from the source binding.
/// @arg {Function} mapback                 The function mapping the incoming value to the source binding.
function MapBinding(_binding, _mapping, _mapback) : ValueBinding(is_undefined(_mapback)) constructor {
    if (is_undefined(_binding))
        return;
    
    /// @ignore
    binding = _binding;
    /// @ignore
    binding_sub = binding.when_changed.subscribe(self, self.check_value);
    /// @ignore
    mapping = _mapping;
    /// @ignore
    mapback = _mapback;
    
    /// @ignore
    current_value = get_underlying();
    
    /// @func create(binding,mapping)
    /// @desc Creates a binding that maps a value from another binding.
    /// @arg {Struct.ValueBinding} binding      The source binding to map the value from.
    /// @arg {Function} mapping                 The function mapping the value from the source binding.
    /// @returns {Struct.MapBinding}
    static create = function(_binding, _mapping) {
        return new MapBinding(_binding, _mapping, undefined);
    }
    
    /// @func create_one_way(binding,mapping)
    /// @desc Creates a binding that maps a value from another binding.
    /// @arg {Struct.ValueBinding} binding      The source binding to map the value from.
    /// @arg {Function} mapping                 The function mapping the value from the source binding.
    /// @returns {Struct.MapBinding}
    static create_one_way = function(_binding, _mapping) {
        return create(_binding, _mapping);
    }
    
    /// @func create_two_way(binding,mapping,mapback)
    /// @desc Creates a binding that maps a value from/to another binding.
    /// @arg {Struct.ValueBinding} binding      The source binding to map the value from/to.
    /// @arg {Function} mapping                 The function mapping the value from the source binding.
    /// @arg {Function} mapback                 The function mapping the incoming value to the source binding.
    /// @returns {Struct.MapBinding}
    static create_two_way = function(_binding, _mapping, _mapback) {
        return new MapBinding(_binding, _mapping, _mapback);
    }
    
    /// @ignore
    static get_underlying = function() {
        return mapping(binding.get_value());
    }
    
    /// @ignore
    static set_underlying = function(_value) {
        binding.set_value(mapback(_value));
    }
}

// initialising static properties
var _base_dummy = new ValueBinding(false);
var _dummy = new MapBinding(undefined, undefined, undefined);
