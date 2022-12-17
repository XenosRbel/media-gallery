const isObject = (value) => value !== null && typeof value === 'object';
const isNone = (value) => value === null || value === undefined;

export const isString = (value) => typeof value === 'string';
const isNumber = (value) => typeof value === 'number';

const isEmpty = (value) => {
  const result = isNone(value);

  if (result) {
    return result;
  }

  if (isString(value)) {
    return !value.trim().length;
  }

  if (isNumber(value)) {
    return !Number.isFinite(value);
  }

  if (Array.isArray(value)) {
    return !value.length;
  }

  if (isObject(value)) {
    return !Object.keys(value).length;
  }

  return false;
};

export const buildObjectWithoutEmptyFields = (sourceObject) =>
  Object.entries(sourceObject).reduce(
    (accumulator, [key, value]) => (isEmpty(value) ? accumulator : { ...accumulator, [key]: value }),
    {},
  );

export const replaceKeys = (object, replaceMap) =>
  Object.entries(object).reduce((accumulator, [key, value]) => {
    const newKey = replaceMap[key];

    return {
      ...accumulator,
      [newKey || key]: value,
    };
  }, {});
