// Kick off once first message is received
self.addEventListener('message', function () {
  var worker  = self;
  var sse     = new EventSource('http://localhost:7654/events');
  var helpers = {
    toJSON: function (string) {
      try {
        return JSON.parse(string);
      } catch (_) {
        return {};
      }
    },
  };

  // Post message to site that uses this worker
  // on message from the Event Source
  sse.onmessage = function (event) {
    worker.postMessage(helpers.toJSON(event.data));
  };

});
