var autoprefixer = require('autoprefixer');

module.exports = {
  context: __dirname,
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
        loaders: ['style', 'css', 'postcss', 'sass'],
      },

    ],
  },
  postcss: function () {
    return [autoprefixer];
  },
};
