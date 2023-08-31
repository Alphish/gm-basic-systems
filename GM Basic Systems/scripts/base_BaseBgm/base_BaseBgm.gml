function BaseBgm() constructor {
    static play = function() {
        throw "Must implement play.";
    }
    
    static apply_volume = function(_volume) {
        // nothing here
    }
    
    static stop = function() {
        throw "Must implement stop."
    }
}
