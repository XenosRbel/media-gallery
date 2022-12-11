import { DEFAULT_SYSTEM_GROUP_NAME, POST_HTTP_METHOD, ERROR } from '../constants/common';
import { getErrorStatusByErrorCode } from './common';
import { createTranslateAttributeFor } from '../../common/utils';
import { sendDataRequest } from '../../common/http';

export const translateAttribute = createTranslateAttributeFor('media_gallery/file');

export const buildFormData = ({ file, groupId = null, description = '' }) => {
  const formData = new FormData();

  if (description !== null) formData.append('file[description]', description);

  if (groupId !== null) formData.append('file[media_gallery_group_id]', groupId);

  if (file !== null) formData.append('file[item]', file);

  return formData;
};

export const getDefaultGroupOption = (groupOptions) =>
  Object.values(groupOptions).find((item) => item.label === DEFAULT_SYSTEM_GROUP_NAME) || {};

export const handleSubmitFile = async (params, formUrl, groupId) => {
  const { onSuccess, onError, file } = params;

  if (file) {
    const formData = buildFormData({ ...params, groupId });

    const data = await sendDataRequest(POST_HTTP_METHOD, formUrl, formData);

    const errorStatus = getErrorStatusByErrorCode(data.status);

    if (errorStatus === ERROR) {
      const {
        data: { errors: errorMessages },
      } = data;

      onError({ statusText: Object.values(errorMessages?.item || []).join(',') });
    } else {
      onSuccess(data, file, null);
    }
  }
};
