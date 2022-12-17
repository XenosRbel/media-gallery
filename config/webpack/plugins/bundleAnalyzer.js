const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer');

module.exports = new BundleAnalyzerPlugin({
  analyzerMode: process.env.WEBPACK_BUNDLE_ANALYZER_MODE || 'server',
  analyzerHost: process.env.WEBPACK_BUNDLE_ANALYZER_HOST || 'localhost',
  analyzerPort: parseInt(process.env.WEBPACK_BUNDLE_ANALYZER_PORT, 10) || 8888,
  reportFilename: process.env.WEBPACK_BUNDLE_ANALYZER_REPORT_FILE || 'report.html',
  defaultSizes: process.env.WEBPACK_BUNDLE_ANALYZER_DEFAULT_SIZES || 'parsed',
  openAnalyzer: process.env.WEBPACK_BUNDLE_ANALYZER_OPEN === 'true',
  generateStatsFile: process.env.WEBPACK_BUNDLE_ANALYZER_GENERATE_STATS === 'true',
  statsFilename: process.env.WEBPACK_BUNDLE_ANALYZER_STATS_FILE || 'stats.json',
  logLevel: process.env.WEBPACK_BUNDLE_ANALYZER_LOG_LEVEL || 'info',
});
