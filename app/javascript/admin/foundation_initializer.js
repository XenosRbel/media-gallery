const jquery = require('jquery');

window.$ = jquery;
window.jquery = jquery;
window.jQuery = jquery;

require('foundation-sites/js/foundation');

$(() => $(document).foundation());
