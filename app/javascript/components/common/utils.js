import axios from 'axios';

export const fetchCollection = async (url, params) => {
  try {
    const { data } = await axios.get(url, { params });

    return data;
  } catch {
    return {};
  }
};
