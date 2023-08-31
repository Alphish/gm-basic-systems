/// @function bgm_play(bgm)
/// @desc Loops a given background music, while stopping the previous one.
/// @arg {String,Asset.GMSound} bgm     The background music to play.
function bgm_play(_bgm) {
    sys_Bgm.select_bgm(_bgm);
}

/// @function bgm_stop()
/// @desc Stops the currently playing background music, if any.
/// @returns {Undefined}
function bgm_stop() {
    sys_Bgm.select_bgm(undefined);
}

/// @function bgm_get_volume()
/// @desc Gets the current background music volume.
/// @returns {Real}
function bgm_get_volume() {
    return sys_Bgm.get_volume();
}

/// @function bgm_set_volume(volume)
/// @desc Sets the current background music volume.
/// @arg {Real} volume              The new volume to set.
function bgm_set_volume(_volume) {
    sys_Bgm.set_volume(_volume);
}

/// @function bgm_mute()
/// @desc Mutes the background music.
function bgm_mute() {
    sys_Bgm.set_volume(0);
}

/// @function bgm_unmute()
/// @desc Unmutes the background music.
function bgm_unmute() {
    sys_Bgm.set_volume(sys_Bgm.bgm_volume);
}

/// @function bgm_toggle()
/// @desc Toggles the background music between the muted and unmuted state.
function bgm_toggle() {
    if (sys_Bgm.is_muted)
        bgm_unmute();
    else
        bgm_mute();
}
