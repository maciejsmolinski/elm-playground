// Kick off once first message is received
self.addEventListener('message', function () {
  self.postMessage('Ready');
});
