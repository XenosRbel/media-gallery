export const POST_HTTP_METHOD = 'post';
export const PUT_HTTP_METHOD = 'put';
export const DELETE_HTTP_METHOD = 'delete';
export const GET_HTTP_METHOD = 'get';

export const SUCCESS = 'success';
export const ERROR = 'error';

export const ERROR_STATUS_CODES = [400, 422];
export const ERROR_STATUSES = [ERROR];
export const SUCCESS_STATUS_CODES = [200, 201, 204];
export const SUCCESS_STATUSES = [SUCCESS, 'done'];

export const ALLERT_TYPE_STATUSES_MAP = {
  [ERROR]: ERROR_STATUS_CODES + ERROR_STATUSES,
  [SUCCESS]: SUCCESS_STATUS_CODES + SUCCESS_STATUSES,
};

export const DEFAULT_SYSTEM_GROUP_NAME = 'General';

export const FILE_DEFAULT_ATTRIBUTES = {
  description: '',
  filesize: 0,
  groupId: 0,
  groupName: '',
  height: 0,
  id: 0,
  name: '',
  originalImage: '',
  thumbnailImage: '',
  url: '',
  width: 0,
};
