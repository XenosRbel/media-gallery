import { DEFAULT_SYSTEM_GROUP_NAME, POST_HTTP_METHOD, ERROR } from '../constants/common';
import { getErrorStatusByErrorCode } from './common';
import { createTranslateAttributeFor } from '../../common/utils';
import { sendDataRequest } from '../../../../front/utils/http';

export const translateAttribute = createTranslateAttributeFor('media_gallery/file');

export const buildFormData = ({ file, folderId = null, description = '' }) => {
  const formData = new FormData();

  if (description !== null) formData.append('file[description]', description);

  if (folderId !== null) formData.append('file[media_gallery_folder_id]', folderId);

  if (file !== null) formData.append('file[item]', file);

  return formData;
};

export const getDefaultGroupOption = (folderOptions) =>
  Object.values(folderOptions).find((item) => item.label === DEFAULT_SYSTEM_GROUP_NAME) || Object.values(folderOptions)[0];

export const handleSubmitFile = async (params, formUrl, folderId) => {
  const { onSuccess, onError, file } = params;

  if (file) {
    const formData = buildFormData({ ...params, folderId });

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
