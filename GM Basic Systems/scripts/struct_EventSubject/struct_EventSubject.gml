/// @func EventSubject()
/// @desc A simple event subject that can raise an arbitrary event.
function EventSubject() constructor {
    /// @ignore
    subs = [];
    /// @ignore
    subs_map = {};
    
    /// @func send(data)
    /// @desc Emits an event with the given data, to be handled by all observers.
    /// @arg {Any} data     The data to process by event handlers.
    static send = function(_data) {
        array_foreach(subs, method({ _data: _data }, function(_sub) {
            _sub.handle(_data);
        }));
    }
    
    /// @func subscrobe(observer,handler)
    /// @desc Creates a new subscription for a given observer, processing incoming events with the given handler.
    /// @arg {Any} observer         The observer who processes the events.
    /// @arg {Function} handler     A function that processes event data within the observer's context.
    /// @returns {Struct.EventSubscription}
    static subscribe = function(_observer, _handler) {
        var _sub = new EventSubscription(self, _observer, _handler);
        var _sub_index = array_length(subs);
        subs[_sub_index] = _sub;
        subs_map[$ string(ptr(_sub))] = _sub_index;
        show_debug_message(subs_map);
        return _sub;
    }
    
    /// Internal function for removing subscriptions
    /// @ignore
    static unsubscribe = function(_sub) {
        var _sub_key = string(ptr(_sub));
        var _sub_index = subs_map[$ _sub_key];
        struct_remove(subs_map, _sub_key);
        
        // move the last sub in place of the just removed sub
        var _last_sub = array_last(subs);
        if (_last_sub != _sub) {
            subs[_sub_index] = _last_sub;
            subs_map[$ string(ptr(_last_sub))] = _sub_index;
        }
        
        array_resize(subs, array_length(subs) - 1);
    }
}
