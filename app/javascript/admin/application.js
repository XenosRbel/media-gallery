require('./i18n_initialize');

window._ = require('underscore');

window.$ = window.jquery = window.jQuery = require('jquery');
require('jquery-ui-bundle');
require('jquery-ujs');

require('html5shiv');

require('datatables.net-zf');

require('cocoon-rails');
require('chosen-js');

require('./foundation_initializer');

// creates ./components require context but excludes *.spec.js | *.spec.jsx files
const componentRequireContext = require.context('./components', true, /^(?!.*\.spec(\.jsx?)?$)\.\/.*$/);
const ReactRailsUJS = require('react_ujs');

ReactRailsUJS.useContext(componentRequireContext);
