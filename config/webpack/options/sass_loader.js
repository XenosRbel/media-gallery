const { resolve } = require('path');

module.exports = {
  sourceMap: true,
  includePaths: [
    resolve('app', 'javascript', 'src'),
    resolve('node_modules'),
  ],
};
