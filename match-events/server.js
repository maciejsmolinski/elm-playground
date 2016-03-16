(function () {
  'use strict';

  var chance = new (require('chance'))();

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

    get randomEvent() {
      return chance.pickone(helpers.matchEvents);
    },

    get randomTimeout() {
      return chance.integer({ min: 1000, max: 5000 });
    },

    randomResponse: function (req, res) {
      setTimeout(function () {
        res.write('id: ' + (+new Date()) + '\n');
        res.write('data: ' + JSON.stringify(helpers.randomEvent) + '\n\n');
        res.write('\n');

        helpers.randomResponse(req, res);
      }, helpers.randomTimeout);
    },
  };

  var app = require('express')();

  app.use(function (req, res, next) {
    res.setHeader('Access-Control-Allow-Origin', '*');
    next();
  });

  app.get('/', function (req, res) {
    res.send(
      'Use `new EventSource(\'http://localhost:7654/events\')` to connect with the EventSource`'
    );
  });

  app.use('/events', function (req, res) {
    res.writeHead(200, {
      'Content-Type':  'text/event-stream',
      'Cache-Control': 'no-cache',
      Connection:      'keep-alive',
    });

    helpers.randomResponse(req, res);
  });

  app.listen(7654);

}());
