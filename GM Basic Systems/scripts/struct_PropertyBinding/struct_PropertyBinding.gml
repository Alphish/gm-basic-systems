/// feather ignore GM2043

/// @func PropertyBinding(owner,property,readonly)
/// @desc A binding to a property of an instance or a struct.
/// @arg {Struct,Id.Instance} owner     The instance or a struct the bound property belongs to.
/// @arg {String} property              The name of the bound property.
/// @arg {Bool} readonly                Whether the binding value can only be read, or if it can be written too.
function PropertyBinding(_owner, _property, _readonly) : ValueBinding(_readonly) constructor {
    if (is_undefined(_owner))
        return;
    
    if (!is_struct(_owner) && !instance_exists(_owner))
        throw "The owner of the property binding must be either a struct or an instance.";
    
    if (!is_string(_property))
        throw "The property name of the property binding must be a string.";
    
    /// @ignore
    owner = _owner;
    /// @ignore
    property = _property;
    /// @ignore
    current_value = get_underlying();
    
    /// @func create(owner,property)
    /// @desc Creates a readable/writeable binding to a property of an instance or a struct.
    /// @arg {Struct,Id.Instance} owner     The instance or a struct the bound property belongs to.
    /// @arg {String} property              The name of the bound property.
    static create = function(_owner, _property) {
        return new PropertyBinding(_owner, _property, false);
    }
    
    /// @func create_readonly(owner,property)
    /// @desc Creates a readonly binding to a property of an instance or a struct.
    /// @arg {Struct,Id.Instance} owner     The instance or a struct the bound property belongs to.
    /// @arg {String} property              The name of the bound property.
    static create_readonly = function(_owner, _property) {
        return new PropertyBinding(_owner, _property, true);
    }
    
    /// @ignore
    static get_underlying = function() {
        return owner[$ property];
    }
    
    /// @ignore
    static set_underlying = function(_value) {
        owner[$ property] = _value;
    }
}

// initialising static properties
var _base_dummy = new ValueBinding(false);
/// feather ignore GM1041
var _dummy = new PropertyBinding(undefined, undefined, false);
