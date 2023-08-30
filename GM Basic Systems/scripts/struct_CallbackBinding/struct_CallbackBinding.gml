/// @func CallbackBinding(getter,setter,readonly)
/// @desc A binding that uses getter and setter callbacks for managing its values.
/// @arg {Function} getter      The function to retrieve the bound value.
/// @arg {Function} setter      The function to set the bound value.
/// @arg {Bool} readonly        Whether the binding value can only be read, or if it can be written too.
function CallbackBinding(_getter, _setter) : ValueBinding(is_undefined(_setter)) constructor {
    if (is_undefined(_getter))
        return;
    
    /// @ignore
    get_underlying = _getter;
    /// @ignore
    set_underlying = _setter;
    /// @ignore
    current_value = get_underlying();
    
    /// @func create(getter,setter)
    /// @desc Creates a binding that uses getter and setter callbacks for reading/writing its values.
    /// @arg {Function} getter      The function to retrieve the bound value.
    /// @arg {Function} setter      The function to set the bound value.
    /// @returns {Struct.CallbackBinding}
    static create = function(_getter, _setter) {
        return new CallbackBinding(_getter, _setter);
    }
    
    /// @func create_readonly(getter)
    /// @desc Creates a readonly binding that uses a given getter callback to retrieve its value.
    /// @arg {Function} getter      The function to retrieve the bound value.
    /// @returns {Struct.CallbackBinding}
    static create_readonly = function(_getter) {
        return new CallbackBinding(_getter, undefined);
    }
}

// initialising static properties
var _base_dummy = new ValueBinding(false);
var _dummy = new CallbackBinding(undefined, undefined);
