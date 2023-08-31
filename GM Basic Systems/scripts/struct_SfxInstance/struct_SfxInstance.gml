function SfxInstance(_sound, _priority, _gain, _volume, _pitch) constructor {
    base_gain = _gain;
    instance = audio_play_sound(_sound, _priority, false, _gain * _volume, 0, _pitch);
    
    /// @ignore
    static is_playing = function() {
        return audio_is_playing(instance);
    }
    
    /// @ignore
    static apply_volume = function(_volume) {
        audio_sound_gain(instance, base_gain * _volume, 0);
    }
    
    /// @ignore
    static stop = function() {
        audio_stop_sound(instance);
    }
}
