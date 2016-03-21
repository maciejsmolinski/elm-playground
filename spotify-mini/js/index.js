var Elm = require('../elm/Main.elm');
var css = require('../css/style.scss');

var local = {
  Main: function (app) {
    var sse = new Worker('js/worker.js');

    // Log Messages to console
    sse.addEventListener('message', function (message) {
      console.log('[Worker] Received "%s" with %o', message.data.type, message.data.payload);
    });

    // Albums Handler
    sse.addEventListener('message', function (message) {
      if (message.data.type !== 'albums') {
        return;
      }

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

      message.data.payload.tracks.items
      .map(function (track) {
        return {
          name:    track.name,
          preview: track.preview_url,
          cover:   (message.data.payload.images[0] ||
                   { url: 'http://placehold.it/640x640?text=Cover' })
                   .url,
        };
      })
      .forEach(function (track) {
        var container = document.createElement('div');
        var title     = document.createElement('h4');
        var audio     = document.createElement('audio');
        var cover     = document.createElement('img');

        container.style = 'margin-top: 3em';
        title.innerText = track.name;
        audio.src       = track.preview;
        audio.controls  = 'controls';
        cover.src       = track.cover;
        cover.width     = 200;
        cover.height    = 200;

        container.appendChild(title);
        container.appendChild(cover);
        container.appendChild(audio);

        document.body.appendChild(container);
      });
    });

    // Dispatch to Elm application
    sse.addEventListener('message', function (message) {
      // app.ports.events.send(message.data);
    });

    sse.postMessage({
      type:    'albums',
      payload: 'Dub FX',
    });
  },
};

var helpers = {

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

  var app = Elm.embed(
    Elm[config.module],
    config.element,
    {} //Default Ports Data
  );

  // Once App bound to element, init local js interop
  if (local[config.module]) {
    local[config.module](app);
  }
});
