const cjsxLoader = {
  test: /\.cjsx$/,
  use: ['coffee-loader', 'cjsx-loader'],
};

module.exports = cjsxLoader;
