current_volume = default_volume;
is_muted = false;

all_sfxs = {};
sfx_instances = [];

sfx_register = function(_name, _bgm) {
    all_sfxs[$ _name] = _bgm;
}

do_play = function(_sfx) {
    if (is_undefined(_sfx) || is_muted)
    	return;
    
    if (!is_string(_sfx)) {
        var _sound = _sfx;
        _sfx = audio_get_name(_sfx);
        if (!struct_exists(all_sfxs, _sfx) && auto_define) {
            SimpleSfx.define(_sfx, _sound);
        }
    }
    
    var _sfx_definition = all_sfxs[$ _sfx];
    if (is_undefined(_sfx_definition))
        throw $"Unknown sound effect: '{_sfx}'.";
    
    var _volume = current_volume / max_volume;
	var _sfx_instance = _sfx_definition.play(_volume);
	array_push(sfx_instances, _sfx_instance);
}

get_volume = function() {
    if (!is_muted)
        return sfx_volume;
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

do_mute = function() {
    is_muted = true;
    array_foreach(sfx_instances, function(_instance) {
		_instance.stop();
	});
	sfx_instances = [];
}

do_unmute = function() {
    is_muted = false;
}

apply_volume = function(_volume) {
	current_volume = _volume;
    array_foreach(sfx_instances, function(_instance) {
		_instance.apply_volume(current_volume / max_volume);
	});
}
