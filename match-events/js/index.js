var Elm = require('../elm/Main.elm');
var css = require('../css/style.scss');

var local = {
  Main: function (app) {
    var sse;

    // Web Worker Generated Events.
    // Enabled by default so no server is required to run the demo
    sse = new Worker('js/workerevents.js');

    // Server Sent Events.
    // Require `node server.js` to run in the background
    // Uncomment to use them:
    // sse = new Worker('js/sse.js');

    setTimeout(function () {
      sse.postMessage(true);
    });

    sse.addEventListener('message', function (message) {
      app.ports.addEvent.send(message.data);

      // This code retriggers animation on given element
      // Reference: https://css-tricks.com/restart-css-animation/#article-header-id-0
      helpers
        .toArray(document.querySelectorAll('.animated'))
        .forEach(function (element) {
          var oldClasses = element.className;

          element.className = '';
          element.offsetWidth = element.offsetWidth;
          element.className = oldClasses;
        });
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

  var app = Elm[config.module].embed(
    config.element
  );

  // Once App bound to element, init local js interop
  if (local[config.module]) {
    local[config.module](app);
  }
});
