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
};
