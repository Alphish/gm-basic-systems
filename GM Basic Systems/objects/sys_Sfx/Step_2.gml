var _old_count = array_length(sfx_instances);
var _new_count = array_filter_ext(sfx_instances, function (_instance) {
	return _instance.is_playing();
});

if (_old_count != _new_count) {
	array_resize(sfx_instances, _new_count);
}
