/// @func SfxDefinition()
/// @desc A definition of the sound effect to play.
/// @arg {Asset.GMSound} sound      The SFX sound asset to play.
function SimpleSfx(_sound) constructor {
    if (is_undefined(_sound))
        return;
    
    sound_asset = _sound;
    priority = 0;
    min_gain = 1;
    max_gain = 1;
    min_pitch = 1;
    max_pitch = 1;
    
    /// @func define(name,sound)
    /// @desc Defines a simple sound effect.
    /// @arg {String} name              The name to reference the sound effect.
    /// @arg {Asset.GMSound} sound      The sound asset to associate with the name.
    /// @returns {Struct.SimpleSfx}
    static define = function(_name, _sound) {
        var _sfx = new SimpleSfx(_sound);
        sys_Sfx.sfx_register(_name, _sfx);
        return _sfx;
    }
    
    /// @func define_from_sound(sound)
    /// @desc Defines a simple sound effect, keyed by the sound asset.
    /// @returns {Struct.SimpleSfx}
    static define_from_sound = function(_sound) {
        return SimpleSfx.define(audio_get_name(_sound), _sound);
    }
    
    /// @func with_priority(priority)
    /// @desc Sets the priority of the sound effect.
    /// @arg {Real} priority        The priority to set.
    /// @returns {Struct.SimpleSfx}
    static with_priority = function(_priority) {
        priotity = _priority;
        return self;
    }
    
    /// @func with_gain(gain)
    /// @desc Sets the gain of the sound effect.
    /// @arg {Real} gain            The gain to set.
    /// @returns {Struct.SimpleSfx}
    static with_gain = function(_gain) {
        min_gain = _gain;
        max_gain = _gain;
        return self;
    }
    
    /// @func with_gain_range(minimum,maximum)
    /// @desc Sets the random gain range of the sound effect.
    /// @arg {Real} minimum         The minimum gain of the sound effect.
    /// @arg {Real} maximum         The maximum gain of the sound effect.
    /// @returns {Struct.SimpleSfx}
    static with_gain_range = function(_minimum, _maximum) {
        min_gain = _minimum;
        max_gain = _maximum;
        return self;
    }
    
    /// @func with_pitch(pitch)
    /// @desc Sets the pitch of the sound effect.
    /// @arg {Real} pitch           The pitch to set.
    /// @returns {Struct.SimpleSfx}
    static with_pitch = function(_pitch) {
        min_pitch = _pitch;
        max_pitch = _pitch;
        return self;
    }
    
    /// @func with_pitch_range(minimum,maximum)
    /// @desc Sets the random pitch range of the sound effect.
    /// @arg {Real} minimum         The minimum pitch of the sound effect.
    /// @arg {Real} maximum         The maximum pitch of the sound effect.
    /// @returns {Struct.SimpleSfx}
    static with_pitch_range = function(_min_pitch, _max_pitch) {
        min_pitch = _min_pitch;
        max_pitch = _max_pitch;
        return self;
    }
    
    /// @func with_pitch_variation(variation)
    /// @desc Sets the pitch variation of the sound effect.
    /// @arg {Real} variation       The variation of the sound effect pitch.
    /// @returns {Struct.SimpleSfx}
    static with_pitch_variation = function(_variation) {
        var _pitch1 = 1 + _variation;
        var _pitch2 = 1 / _pitch1;
        min_pitch = min(_pitch1, _pitch2);
        max_pitch = max(_pitch1, _pitch2);
        return self;
    }
    
    /// @ignore
    static play = function(_volume) {
        return new SfxInstance(sound_asset, priority, random_range(min_gain, max_gain), _volume, random_range(min_pitch, max_pitch));
    }
}

// initialising static properties
var _dummy = new SimpleSfx(undefined);
