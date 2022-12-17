/* eslint-disable global-require */
module.exports = (api) => {
  const validEnv = ['development', 'test', 'production'];
  const currentEnv = api.env();
  const isDevelopmentEnv = api.env('development');
  const isProductionEnv = api.env('production');
  const isTestEnv = api.env('test');

  if (!validEnv.includes(currentEnv)) {
    throw new Error(
      [
        'Please specify a valid `NODE_ENV` or ',
        '`BABEL_ENV` environment variables. Valid values are "development", ',
        '"test", and "production". Instead, received: ',
        JSON.stringify(currentEnv),
        '.',
      ].join(''),
    );
  }

  const presets = [
    isTestEnv && [
      require('@babel/preset-env').default,
      { targets: { node: 'current' } },
    ],
    (isProductionEnv || isDevelopmentEnv) && [
      require('@babel/preset-env').default,
      {
        modules: false,
        useBuiltIns: 'entry',
        forceAllTransforms: true,
        targets: { browsers: '> 1%' },
        corejs: 2,
        exclude: ['transform-typeof-symbol'],
      },
    ],
    [require('@babel/preset-react')],
  ].filter(Boolean);

  const plugins = [
    [require('babel-plugin-import'), { libraryName: 'antd' }],
    require('babel-plugin-macros'),
    require('@babel/plugin-syntax-dynamic-import').default,
    isTestEnv && require('babel-plugin-dynamic-import-node'),
    require('@babel/plugin-transform-destructuring').default,
    [
      require('@babel/plugin-proposal-class-properties').default,
      { loose: true },
    ],
    [
      require('@babel/plugin-proposal-object-rest-spread').default,
      { useBuiltIns: true },
    ],
    [
      require('@babel/plugin-transform-runtime').default,
      { helpers: false, regenerator: true },
    ],
    [
      require('@babel/plugin-transform-regenerator').default,
      { async: false },
    ],
  ].filter(Boolean);

  return { presets, plugins };
};
/* eslint-enable global-require */
