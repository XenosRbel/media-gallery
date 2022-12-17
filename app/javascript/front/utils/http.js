import axios from 'axios';
import queryString from 'query-string';

export const defaultAjaxHeaders = { 'X-Requested-With': 'XMLHttpRequest' };

export const createRequest = (url, method, params, options) => axios[method](url, { ...options, params });

export const buildURLQuery = (object, prefix) =>
  Object.keys(object)
    .map((property) => {
      const key = prefix ? `${prefix}[${property}]` : property;
      const value = object[property];

      return value !== null && typeof value === 'object'
        ? buildURLQuery(value, key)
        : `${encodeURIComponent(key)}=${encodeURIComponent(value)}`;
    })
    .join('&');

export const parseQueryString = (query = window.location.search) =>
  queryString.parse(query, { arrayFormat: 'bracket' });

export const sendDataRequest = async (method, submitPath, formData) => {
  const csrfToken = document.querySelector('[name=csrf-token]').content;

  try {
    const { data, status } = await axios[method](submitPath, formData, {
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

export const makeMultipleDeleteRequest = async (url, objectData, objectName) => {
  const csrfToken = document.querySelector('[name=csrf-token]').content;

  try {
    const { data, status } = await axios.delete(url, {
      data: { [objectName]: objectData },
      headers: {
        'X-CSRF-TOKEN': csrfToken,
        accept: 'application/json',
      },
    });

    return { data: { ...data }, method: 'delete', status };
  } catch (error) {
    const { data, status } = error.response;

    return { data, method: 'delete', status };
  }
};
