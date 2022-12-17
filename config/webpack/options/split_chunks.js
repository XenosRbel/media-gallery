const NEW_FRONT_PACKS = ['server_rendering', 'front/monoblocks', 'front/application'];
const WITHOUT_CHUNKS_PACKS = ['front/gallery', 'front/jquery', 'front/light_landing', 'front/landing'];

module.exports = {
  optimization: {
    splitChunks: {
      chunks: 'async',
      minChunks: 1,
      cacheGroups: {
        vendor: {
          test: /[\\/]node_modules[\\/]/,
          priority: -10,
          name: 'vendor',
        },
        front_common: {
          test: /\.(?!css$)[^.]+$/,
          chunks({ name }) {
            return !NEW_FRONT_PACKS.includes(name) && !WITHOUT_CHUNKS_PACKS.includes(name);
          },
          minChunks: 2,
          priority: -20,
          name: 'front_common',
          reuseExistingChunk: true,
        },
        application_common: {
          test: /\.(?!css$)[^.]+$/,
          chunks({ name }) {
            return NEW_FRONT_PACKS.includes(name) && !WITHOUT_CHUNKS_PACKS.includes(name);
          },
          minChunks: 3,
          priority: -20,
          name: 'application_common',
          reuseExistingChunk: true,
        },
      },
    },
  },
};
