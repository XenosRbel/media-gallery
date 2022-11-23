// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import * as bootstrap from "bootstrap"

window._ = require('underscore');

window.$ = window.jquery = window.jQuery = require('jquery');

// creates ./components require context but excludes *.spec.js | *.spec.jsx files
const componentRequireContext = require.context('./components', true, /^(?!.*\.spec(\.jsx?)?$)\.\/.*$/);
const ReactRailsUJS = require('react_ujs');

ReactRailsUJS.useContext(componentRequireContext);
