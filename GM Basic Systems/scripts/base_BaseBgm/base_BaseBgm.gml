/// @func BaseBgm()
/// @desc A base class for BGM blueprints.
function BaseBgm() constructor {
    /// @ignore
    static play = function() {
        throw $"{instanceof(self)}.play() is not implemented.";
    }
    
    /// @ignore
    static is_playing = function() {
        throw $"{instanceof(self)}.is_playing() is not implemented."
    }
    
    /// @ignore
    static apply_volume = function(_volume) {
        throw $"{instanceof(self)}.apply_volume(volume) is not implemented."
    }
    
    /// @ignore
    static stop = function() {
        throw $"{instanceof(self)}.stop() is not implemented."
    }
}
