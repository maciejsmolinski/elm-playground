importScripts('worker-helpers.js');

var handlers = {
  albums: function (payload) {
    var query = encodeURIComponent(payload);
    var url   = 'https://api.spotify.com/v1/search?q=' + query + '&type=album';

    return helpers.json(url);
  },
};
