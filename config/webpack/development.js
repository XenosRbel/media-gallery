process.env.NODE_ENV = process.env.NODE_ENV || 'development';

const webpack = require('webpack');
const environment = require('./environment');

environment.plugins.prepend('ProgressPlugin', new webpack.ProgressPlugin());

module.exports = environment.toWebpackConfig();
