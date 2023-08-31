/// @func SimpleBgm(asset,gain,pitch)
/// @desc A struct representing a simple looping background music.
/// @arg {Asset.GMSound} sound      The BGM sound asset to play.
function SimpleBgm(_sound) : BaseBgm() constructor {
    if (is_undefined(_sound))
        return;
    
    sound_asset = _sound;
    gain = 1;
    pitch = 1;
    instance = undefined;
    
    /// @func define(name,sound)
    /// @desc Defines a simple looped background music.
    /// @arg {String} name              The name to reference the background music.
    /// @arg {Asset.GMSound} sound      The sound asset to associate with the name.
    /// @returns {Struct.SimpleBgm}
    static define = function(_name, _sound) {
        var _bgm = new SimpleBgm(_sound);
        sys_Bgm.bgm_register(_name, _bgm);
        return _bgm;
    }
    
    /// @func define_from_sound(sound)
    /// @desc Defines a simple looped background music, keyed by the sound asset.
    /// @returns {Struct.SimpleBgm}
    static define_from_sound = function(_sound) {
        return SimpleBgm.define(audio_get_name(_sound), _sound);
    }
    
    /// @func with_gain(gain)
    /// @desc Sets the background music gain.
    /// @arg {Real} gain        The background music gain to set.
    /// @returns {Struct.SimpleBgm}
    static with_gain = function(_gain) {
        gain = _gain;
        return self;
    }
    
    /// @func with_pitch(pitch)
    /// @desc Sets the background music pitch.
    /// @arg {Real} gain        The background music pitch to set.
    /// @returns {Struct.SimpleBgm}
    static with_pitch = function(_pitch) {
        pitch = _pitch;
        return self;
    }
    
    /// @ignore
    static play = function(_volume) {
        instance = audio_play_sound(sound_asset, 0, true, gain * _volume, 0, pitch);
    }
    
    /// @ignore
    static is_playing = function() {
        return audio_is_playing(instance);
    }
    
    /// @ignore
    static apply_volume = function(_volume) {
        audio_sound_gain(instance, gain * _volume, 0);
    }
    
    /// @ignore
    static stop = function() {
        audio_stop_sound(instance);
        instance = undefined;
    }
}

// initialising static properties
var _base_dummy = new BaseBgm();
var _dummy = new SimpleBgm(undefined);