importScripts('worker-helpers.js', 'worker-envelopes.js', 'worker-handlers.js');

// Send Ready Status
self.postMessage(envelopes.status('ready'));

// Setup Generic Evnent Listener
self.addEventListener('message', function (message) {
  if (typeof message.data !== 'object') {
    return;
  }

  // If handler (e.g. HTTP query) is not defined, escape
  if (!(message.data.type in handlers)) {
    return;
  }

  // If envelope for received data is not defined, escape
  if (!(message.data.type in envelopes)) {
    return;
  }

  // Query data and postMessage with an enveloped message
  handlers[message.data.type](message.data.payload)
  .then(function (results) {
    self.postMessage(envelopes[message.data.type](results));
  });
});
