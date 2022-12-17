import { ALLERT_TYPE_STATUSES_MAP, ERROR, SUCCESS } from '../constants/common';
import { createTranslateAttributeFor } from '../../common/utils';
import { makeMultipleDeleteRequest } from '../../../../front/utils/http';

export const translateFileAttribute = createTranslateAttributeFor('media_gallery/file');

export const getErrorStatusByErrorCode = (errorCode) => {
  const [errorStatus] =
    Object.entries(ALLERT_TYPE_STATUSES_MAP).find(([_state, statuses]) => statuses.includes(errorCode)) || [];

  return errorStatus;
};

export const handleDeleteFilesByIds = async (url, objectData, objectName) => {
  const data = await makeMultipleDeleteRequest(url, objectData, objectName);

  const errorStatus = getErrorStatusByErrorCode(data.status);

  if (errorStatus === ERROR) {
    const {
      data: { errors: errorMessages },
    } = data;

    return { message: Object.values(errorMessages?.item || []).join(','), status: ERROR };
  }

  return { status: SUCCESS };
};
