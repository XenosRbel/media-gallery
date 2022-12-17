const MiniCssExtractPlugin = require('mini-css-extract-plugin');

const lessLoader = {
  test: /\.less$/,
  use: [
    MiniCssExtractPlugin.loader,
    'css-loader',
    {
      loader: 'less-loader',
      options: {
        javascriptEnabled: true,
      },
    },
  ],
};

module.exports = lessLoader;
