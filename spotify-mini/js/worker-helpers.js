var helpers = {
  json: function (url) {
    return fetch(url).then(function (data) {
      return data.json();
    });
  },
};
