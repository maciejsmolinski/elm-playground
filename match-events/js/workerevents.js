// Kick off once first message is received
self.addEventListener('message', function () {
  var worker  = self;
  var helpers = {
    matchEvents: [
      { code: 'assist',          label: 'Assist' },
      { code: 'own-goal',        label: 'Own goal' },
      { code: 'penalty-goal',    label: 'Penalty goal' },
      { code: 'penalty-saved',   label: 'Penalty saved' },
      { code: 'substitute-in',   label: 'Substitute in' },
      { code: 'substitute-out',  label: 'Substitute out' },
      { code: 'yellow-card',     label: 'Yellow card' },
      { code: 'yellow-red-card', label: 'Second Yellow, Red Card' },
      { code: 'red-card',        label: 'Red card' },
      { code: 'goal',            label: 'Goal' },
      { code: 'penalty-missed',  label: 'Penalty missed' },
    ],

    integer: function (options) {
      options = options || {};
      options.min = ('min' in options) ? options.min :  0;
      options.max = ('max' in options) ? options.max : 10;

      return Math.floor(
        Math.random() * (options.max - options.min + 1)
      ) + options.min;
    },

    pickone: function (array) {
      return array[helpers.integer({ min: 0, max: array.length - 1 })];
    },

    get randomMatchEvent () {
      return helpers.pickone(helpers.matchEvents);
    },

    get randomTimeout () {
      return helpers.integer({ min: 2500, max: 7500 });
    },

    postRandomEvent: function () {
      worker.postMessage(helpers.randomMatchEvent);
    },

    scheduleNextRandomEvent: function () {
      setTimeout(function () {
        helpers.postRandomEvent();
        helpers.scheduleNextRandomEvent();
      }, helpers.randomTimeout);
    },
  };

  // Keep sending random events with `worker.postMessage`
  helpers.scheduleNextRandomEvent();

});
