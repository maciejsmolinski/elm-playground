var envelopes = {

  status: function (status) {
    return {
      type:    'status',
      payload: status,
    };
  },

  albums: function (results) {
    return {
      type:    'albums',
      payload: results,
    };
  },

  tracks: function (results) {
    return {
      type:    'tracks',
      payload: results,
    };
  },
};
