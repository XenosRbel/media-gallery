import axios from 'axios';

import { DISABLED_SELECT_FIELDS, OPENED_STATUS } from './constants';

export const createTranslateAttributeFor = (model) => (attribute) =>
  I18n.t(`admin.activerecord.attributes.${model}.${attribute}`);

const formatRemoteOptions = (options) => options.map(({ id, title }) => ({ label: title, value: id }));

export const loadRemoteOptionsFor = async (path, query = '', format = formatRemoteOptions) => {
  try {
    const params = query.length > 0 ? { query } : {};

    const { data } = await axios.get(path, { params });

    const formattedData = format(data.data || data.content);

    return formattedData;
  } catch (exception) {
    console.error(exception);

    return [];
  }
};

export const sanitizeAttributeName = (name) => name.replace(/Id$/, '');

export const generateUrlFor = (source, name, queryParams) => {
  const params =
    queryParams &&
    Object.entries(queryParams)
      .map(([key, value]) => `${key}=${value}`)
      .join('&');
  const url = `${source}${name}`;

  return params ? [url, params].join('?') : url;
};

export const checkDisabled = (name, status) =>
  status && status === OPENED_STATUS && DISABLED_SELECT_FIELDS.includes(name);

export const submitForm = async (method, submitPath, objectParams, objectName) => {
  const csrfToken = document.querySelector('[name=csrf-token]').content;

  const {
    data: { data },
  } = await axios[method](
    submitPath,
    { [objectName]: objectParams },
    {
      headers: {
        'X-CSRF-TOKEN': csrfToken,
        accept: 'application/json',
      },
    },
  );

  return data;
};

export const getSelectProps = (name, options, record, translateAttribute) => ({
  className: 'row',
  disabled: checkDisabled(name, record.status),
  id: `${name}Select`,
  name,
  options,
  translateAttribute,
  value: record[name],
});

export const getInputProps = (name, onChange, record, translateAttribute) => ({
  className: 'row',
  disabled: checkDisabled(name, record.status),
  id: `${name}Input`,
  label: true,
  name,
  onChange,
  translateAttribute,
  value: record[name],
});

export const formatOptions = (options = [], translateAttribute, scope, upperCase = false) =>
  options.map((option) => ({
    label: translateAttribute(`${scope}.${option}`),
    value: upperCase ? option.toUpperCase() : option,
  }));

export const fetchCollection = async (url, params) => {
  try {
    const { data } = await axios.get(url, { params });

    return data;
  } catch {
    return {};
  }
};

export const submitButton = async (method, submitPath) => {
  const csrfToken = document.querySelector('[name=csrf-token]').content;

  try {
    const { data, status } = await axios[method](submitPath, {
      headers: {
        'X-CSRF-TOKEN': csrfToken,
        accept: 'application/json',
      },
    });

    return { data: { ...data }, method, status };
  } catch (error) {
    const { data, status } = error.response;

    return { data, method, status };
  }
};

const SIZES = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
const DECIMAL_POINT = 2;
const BYTES_IN_KB = 1024;
const BYTES_RATIO = Math.log(BYTES_IN_KB);

export const formatFileSize = (bytes) => {
  if (bytes === 0) return `${bytes} ${SIZES[0]}`;

  const index = Math.floor(Math.log(bytes) / BYTES_RATIO);

  return `${(bytes / BYTES_IN_KB ** index).toFixed(DECIMAL_POINT)} ${SIZES[index]}`;
};
