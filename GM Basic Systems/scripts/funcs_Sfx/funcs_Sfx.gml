/// @function sfx_play(sfx)
/// @desc Plays the given sound effect.
/// @arg {String,Asset.GMSound} sfx		The sound effect to play.
function sfx_play(_sfx) {
	sys_Sfx.do_play(_sfx);
}

/// @function sfx_get_volume()
/// @desc Gets the current sound effects volume.
/// @returns {Real}
function sfx_get_volume() {
	return sys_Sfx.get_volume();
}

/// @function sfx_set_volume(volume)
/// @desc Sets the current sound effects volume.
/// @arg {Real} volume              The new volume to set.
function sfx_set_volume(_volume) {
	sys_Sfx.set_volume(_volume);
}

/// @function sfx_mute()
/// @desc Mutes the sound effects.
function sfx_mute() {
	sys_Sfx.set_volume(0);
}

/// @function sfx_unmute()
/// @desc Unmutes the sound effects.
function sfx_unmute() {
	sys_Sfx.set_volume(sys_Sfx.current__volume);
}

/// @function sfx_toggle()
/// @desc Toggles the sound effects between the muted and unmuted state.
function sfx_toggle() {
	if (sys_Sfx.is_muted)
		sfx_unmute();
	else
		sfx_mute();
}
