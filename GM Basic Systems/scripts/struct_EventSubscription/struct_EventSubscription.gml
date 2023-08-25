/// @func EventSubscription(subject,observer,handler)
/// @desc An event subscription handling incoming events.
/// @arg {Struct.EventSubject} subject      The event subject sending the relevant events.
/// @arg {Any} observer                     The observer who processes the events.
/// @arg {Function} handler                 A function that processes event data within the observer's context.
function EventSubscription(_subject, _observer, _handler) constructor {
    /// @ignore
    subject = _subject;
    /// @ignore
    listener = _observer;
    /// @ignore
    handler = method(_observer, _handler);
    
    /// @ignore
    static handle = function(_data) {
        handler(_data, subject);
    }
    
    /// @func unsubscribe()
    /// @desc Removes the subscription, so that it no longer processes the event.
    static unsubscribe = function() {
        subject.unsubscribe(self);
    }
}
