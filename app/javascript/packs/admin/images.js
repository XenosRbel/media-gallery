const images = require.context('admin/images/', true, /.*/);
images.keys().forEach(images);
