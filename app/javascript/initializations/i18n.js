/* global DEFAULT_LOCALE LOCALE */

const {I18n} = require('i18n-js');

const isBrowser = typeof window !== 'undefined';

if (isBrowser) {
  window.I18n = I18n;
  I18n.defaultLocale = DEFAULT_LOCALE;
  I18n.locale = LOCALE;
} else {
  global.I18n = I18n;
  I18n.defaultLocale = 'ru';
  I18n.locale = 'ru';
}

//require('./common/translations'); // eslint-disable-line import/no-unresolved

I18n.pluralization.ru = (count) => {
  if (count % 10 === 1 && count % 100 !== 11) {
    return ['one'];
  }

  if ([2, 3, 4].indexOf(count % 10) >= 0 && [12, 13, 14].indexOf(count % 100) < 0) {
    return ['few'];
  }

  if (count % 10 === 0 || [5, 6, 7, 8, 9].indexOf(count % 10) >= 0 || [11, 12, 13, 14].indexOf(count % 100) >= 0) {
    return ['many'];
  }

  return ['other'];
};
