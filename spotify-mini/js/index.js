var Elm = require('../elm/Main.elm');
var css = require('../css/style.scss');

var local = {
  Main: function (app) {
    var sse = new Worker('js/worker.js');

    // Log Messages to console
    // sse.addEventListener('message', function (message) {
    //   console.log('[Worker] Received "%s" with %o', message.data.type, message.data.payload);
    // });

    // Albums Handler
    sse.addEventListener('message', function (message) {
      if (message.data.type !== 'albums') {
        return;
      }

      app.ports.clearTrackList.send([]);

      message.data.payload.albums.items
      .map(function (album) {
        return album.id;
      })
      .forEach(function (albumId) {
        sse.postMessage({
          type:    'tracks',
          payload: albumId,
        });
      });

    });

    // Tracks Handler
    sse.addEventListener('message', function (message) {
      if (message.data.type !== 'tracks') {
        return;
      }

      var tracks = message.data.payload.tracks.items
      .map(function (track) {
        return {
          title:   track.name,
          src:     track.preview_url,
          cover:   (message.data.payload.images[0] ||
                   { url: 'http://placehold.it/640x640?text=Cover' })
                   .url,
        };
      });

      app.ports.updateTrackList.send(tracks);
    });

    // Init search
    setTimeout(function () {
      sse.postMessage({
        type:    'albums',
        payload: 'Dub FX',
      });
    });

    // Subscribe to search queries (debounce)
    app.ports.search.subscribe(helpers.debounce(function (query) {
      app.ports.clearTrackList.send([]);

      sse.postMessage({
        type:    'albums',
        payload: query,
      });
    }, 400));

    app.ports.play.subscribe(function () {
      setTimeout(function () {
        document.querySelector('audio').play();
      }, 100);
    });

  },
};

var helpers = {

  debounce: function (callback, time) {
    var timeout;

    return function () {
      var args = helpers.toArray(arguments);

      if (timeout) {
        clearTimeout(timeout);
      }

      timeout = setTimeout(function () {
        callback.apply(null, args);
      }, time);
    };
  },

  toArray: function (data) {
    return [].slice.call(data);
  },

  buildSelector: function buildSelector(element) {
    var selector      = '';
    var parentElement = element.parentElement;
    var classList     = helpers.toArray(element.classList);

    if (parentElement) {
      selector += buildSelector(parentElement) + ' ';
    }

    selector += element.tagName.toLowerCase();

    if (element.id) {
      selector += '#' + element.id;
    }

    if (classList.length) {
      selector += '.' + classList.join('.');
    }

    return selector;
  },

};

helpers.toArray(
  document.querySelectorAll(
    '[data-module]'
  )
)
.map(function (element) {
  return {
    element: element,
    module: element.dataset.module,
  };
})
.forEach(function (config) {
  if (!(config.module in Elm)) {
    throw new Error(
      '[Elm] Module "%s" bound to "%s" not found in Elm namespace'
      .replace('%s', config.module)
      .replace('%s', helpers.buildSelector(config.element))
    );
  }

  var app = Elm[config.module].embed(
    config.element
  );

  // Once App bound to element, init local js interop
  if (local[config.module]) {
    local[config.module](app);
  }
});
