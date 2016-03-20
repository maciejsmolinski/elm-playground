var Elm = require('../elm/Main.elm');
var css = require('../css/style.scss');

var local = {
  Main: function (app) {
    // var sse = new Worker('js/worker.js');
    // sse.addEventListener('message', function (message) { app.ports.events.send(message.data); })
    // sse.postMessage(true);
    console.log('App Main Ready %s', app);
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
