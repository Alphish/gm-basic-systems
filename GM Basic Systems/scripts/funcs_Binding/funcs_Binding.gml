/// @func binding_resolve(value)
/// @desc Retrieves a value from the given binding, or passes the value if it's not a binding.
/// @arg {Any} value        The value/binding to resolve.
/// @returns {Any}
function binding_resolve(_value) {
    return is_instanceof(_value, ValueBinding) ? _value.get_value() : _value;
}
