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
        loaders: ['elm-webpack-loader'],
      },

      {
        test: /\.scss$/,
        loaders: ['style-loader', 'css-loader', 'sass-loader'],
      },

    ],
  },
};
