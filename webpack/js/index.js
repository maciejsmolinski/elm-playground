var Elm = require('../elm/Main.elm');
var css = require('../css/style.scss');

var helpers = {
  toArray: function (data) {
    return [].slice.call(data);
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
      '[Elm] Module "%s" not found'.replace('%s', config.module)
    );
  }

  Elm.embed(
    Elm[config.module],
    config.element
  );
});
