/// @func SimpleBgm(asset,gain,pitch)
/// @desc A struct representing a simple looping background music.
/// @arg {Asset.GMSound} asset      The BGM asset to play.
/// @arg {Real} gain                The loudness of the played BGM (1 by default).
/// @arg {Real} pitch               The pitch of the played BGM (1 by default).
function SimpleBgm(_asset, _gain = 1, _pitch = 1) : BaseBgm() constructor {
    if (is_undefined(_asset))
        return;
    
    asset = _asset;
    gain = _gain;
    pitch = _pitch;
    instance = undefined;
    
    static define = function(_name, _asset, _gain = 1, _pitch = 1) {
        var _bgm = new SimpleBgm(_asset, _gain, _pitch);
        sys_Bgm.bgm_register(_name, _bgm);
    }
    
    static play = function(_volume) {
        instance = audio_play_sound(asset, 0, true, gain * _volume, 0, pitch);
    }
    
    static is_playing = function() {
        return audio_is_playing(instance);
    }
    
    static apply_volume = function(_volume) {
        audio_sound_gain(instance, gain * _volume, 0);
    }
    
    static stop = function() {
        audio_stop_sound(instance);
        instance = undefined;
    }
}

// initialising static properties
var _base_dummy = new BaseBgm();
var _dummy = new SimpleBgm(undefined);