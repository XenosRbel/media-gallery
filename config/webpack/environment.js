const { environment } = require('@rails/webpacker');
const merge = require('webpack-merge');

const { cjsxLoader, coffeeLoader, lessLoader } = require('./loaders');
const { splitChunksOptions, sassLoaderOptions } = require('./options');
const { bundleAnalyzerPlugin } = require('./plugins');
const { customConfig } = require('./config');

const BUNDLE_ANALYZE = process.env.BUNDLE_ANALYZE || false;

environment.loaders.delete('nodeModules');
environment.loaders.prepend('coffee', coffeeLoader);
environment.loaders.prepend('cjsx', cjsxLoader);
environment.loaders.prepend('less', lessLoader);

const sassLoader = environment.loaders.get('sass').use.find(({ loader }) => loader === 'sass-loader');
sassLoader.options = merge(sassLoader.options, sassLoaderOptions);

environment.splitChunks((config) => Object.assign({}, config, splitChunksOptions));

if (BUNDLE_ANALYZE !== false) {
  environment.plugins.prepend('BundleAnalyzerPlugin', bundleAnalyzerPlugin);
}

environment.config.merge(customConfig);

module.exports = environment;
