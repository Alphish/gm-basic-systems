current_volume = default_volume;
is_muted = false;

all_bgms = {};
bgm_name = undefined;
bgm_instance = undefined;

bgm_register = function(_name, _bgm) {
    all_bgms[$ _name] = _bgm;
}

select_bgm = function(_bgm) {
    if (!is_string(_bgm) && !is_undefined(_bgm)) {
        var _sound = _bgm;
        _bgm = audio_get_name(_bgm);
        if (!struct_exists(all_bgms, _bgm) && auto_define) {
            SimpleBgm.define(_bgm, _sound);
        }
    }
    
    if (_bgm == bgm_name)
        return;
    
    do_stop();
    bgm_name = _bgm;
    do_play();
}

get_volume = function() {
    if (!is_muted)
        return current_volume;
    else
        return 0;
}

set_volume = function(_volume) {
    _volume = clamp(round(_volume), 0, max_volume);
    var _should_mute = _volume == 0;
    if (_should_mute && is_muted)
        return;
    else if (_should_mute && !is_muted)
        do_mute();
    else if (!_should_mute && is_muted)
        do_unmute();
    else
        apply_volume(_volume);
}

is_playing = function() {
    return !is_undefined(bgm_instance) && bgm_instance.is_playing();
}

do_stop = function() {
    if (is_playing()) {
        bgm_instance.stop();
        bgm_instance = undefined;
    }
}

do_play = function() {
    if (is_undefined(bgm_name) || is_muted)
        return;
    
    bgm_instance = all_bgms[$ bgm_name];
    if (is_undefined(bgm_instance))
        throw $"Unknown background music: '{bgm_name}'.";
    
    bgm_instance.play(current_volume / max_volume);
}

do_mute = function() {
    is_muted = true;
    do_stop();
}

do_unmute = function() {
    is_muted = false;
    do_play();
}

apply_volume = function(_volume) {
	current_volume = _volume;
    bgm_instance.apply_volume(current_volume / max_volume);
}
