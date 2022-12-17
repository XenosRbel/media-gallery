const environment = require('./environment');

const { minimizer } = require('./config');

environment.config.delete('optimization.minimizer');
environment.config.set('optimization.minimizer', [minimizer]);
environment.config.merge({ devtool: false });

module.exports = environment.toWebpackConfig();
