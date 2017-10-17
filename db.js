'use strict';

var REF_ENTRIES = '/entries/';

function getEntriesRef(datetime) {
    if (datetime) {
        return firebase.database().ref(REF_ENTRIES + datetime);
    } else {
        return firebase.database().ref(REF_ENTRIES);
    }
}

function post(text, onComplete) {
    var datetime = new Date().getTime();
    getEntriesRef(datetime).transaction(function(post) {
        if (post) {
            // no-op
        } else {
            post = { datetime: datetime, text: text };
        }
        return post;
    }, onComplete);
}

function remove(datetime) {
    getEntriesRef(datetime).remove();
}

function setEntryAddedListener(callback) {
    getEntriesRef().on('child_added', callback);
}
