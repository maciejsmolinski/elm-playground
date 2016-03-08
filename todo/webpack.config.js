module.exports = {
  entry: './js/index',
  output: {
    filename: './js/bundle.js',
  },
  module: {
    loaders: [

      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loaders: ['elm-webpack'],
      },

      {
        test: /\.scss$/,
        loaders: ['style', 'css', 'sass'],
      },

    ],
  },
};
