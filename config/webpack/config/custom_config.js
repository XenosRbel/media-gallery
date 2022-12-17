const path = require('path');

const jqueryUiImagePath = (image) => path.resolve('node_modules', 'jquery-ui', 'themes', 'base', 'images', image);
const dataTablesFoundationImagePath = (image) => path.resolve('node_modules', 'datatables.net-zf', 'images', image);
const fontAwesomeFontPath = (font) => path.resolve('node_modules', 'font-awesome', 'fonts', font);

module.exports = {
  resolve: {
    alias: {
      react: require.resolve('react'),
      './ajax-loader.gif': path.resolve('node_modules', 'slick-carousel', 'slick', 'ajax-loader.gif'),
      './chosen-sprite.png': path.resolve('node_modules', 'chosen-js', './chosen-sprite.png'),
      './chosen-sprite@2x.png': path.resolve('node_modules', 'chosen-js', './chosen-sprite@2x.png'),
      '../fonts/FontAwesome.otf': fontAwesomeFontPath('FontAwesome.otf'),
      '../fonts/fontawesome-webfont.eot': fontAwesomeFontPath('fontawesome-webfont.eot'),
      '../fonts/fontawesome-webfont.svg': fontAwesomeFontPath('fontawesome-webfont.svg'),
      '../fonts/fontawesome-webfont.ttf': fontAwesomeFontPath('fontawesome-webfont.ttf'),
      '../fonts/fontawesome-webfont.woff': fontAwesomeFontPath('fontawesome-webfont.woff'),
      '../fonts/fontawesome-webfont.woff2': fontAwesomeFontPath('fontawesome-webfont.woff2'),
      '../images/sort_asc.png': dataTablesFoundationImagePath('sort_asc.png'),
      '../images/sort_asc_disabled.png': dataTablesFoundationImagePath('sort_asc_disabled.png'),
      '../images/sort_both.png': dataTablesFoundationImagePath('sort_both.png'),
      '../images/sort_desc.png': dataTablesFoundationImagePath('sort_desc.png'),
      '../images/sort_desc_disabled.png': dataTablesFoundationImagePath('sort_desc_disabled.png'),
      './images/ui-bg_flat_0_aaaaaa_40x100.png': jqueryUiImagePath('ui-bg_flat_0_aaaaaa_40x100.png'),
      './images/ui-icons_444444_256x240.png': jqueryUiImagePath('ui-icons_444444_256x240.png'),
      './images/ui-icons_555555_256x240.png': jqueryUiImagePath('ui-icons_555555_256x240.png'),
      './images/ui-icons_777620_256x240.png': jqueryUiImagePath('ui-icons_777620_256x240.png'),
      './images/ui-icons_777777_256x240.png': jqueryUiImagePath('ui-icons_777777_256x240.png'),
      './images/ui-icons_cc0000_256x240.png': jqueryUiImagePath('ui-icons_cc0000_256x240.png'),
      './images/ui-icons_ffffff_256x240.png': jqueryUiImagePath('ui-icons_ffffff_256x240.png'),
      './admin_vendor': path.resolve('app', 'javascript', 'vendor', 'admin'),
      './front_vendor': path.resolve('app', 'javascript', 'vendor', 'front'),
      './admin_src': path.resolve('app', 'javascript', 'src', 'admin'),
      './front': path.resolve('app', 'javascript', 'front'),
      './front_src': path.resolve('app', 'javascript', 'src', 'front'),
    },
  },
  optimization: {
    runtimeChunk: false,
  },
  output: {
    globalObject: 'this',
  },
  stats: 'none',
};
