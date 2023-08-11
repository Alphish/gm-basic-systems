if (transition_is_leaving())
    return;

transition_make().entering_room(target_room);
