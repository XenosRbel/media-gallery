import { handleDeleteFilesByIds } from '../common';
import httpUtils, { makeMultipleDeleteRequest } from '../../../../../front/utils/http';
import { SUCCESS, ERROR } from '../../constants/common';

jest.mock('../../../../../front/utils/http', () => ({
  ...jest.requireActual('../../../../../front/utils/http'),
  makeMultipleDeleteRequest: jest.fn(),
}));

describe('Utility: handleDeleteFilesByIds', () => {
  let result;
  const objectName = 'ids';
  const ids = [1, 2, 3];
  const url = 'http://example.example/path';

  let axiosResult;

  beforeEach(async () => {
    result = await handleDeleteFilesByIds(url, ids, objectName);
  });

  httpUtils.makeMultipleDeleteRequest.mockImplementation(() => axiosResult);

  describe('when request is successful', () => {
    beforeAll(() => {
      axiosResult = { data: {}, status: 200 };
    });

    it('should call makeMultipleDeleteRequest', () => {
      expect(makeMultipleDeleteRequest).toHaveBeenCalledTimes(1);
    });

    it('should return SUCCESS status', () => {
      expect(result).toStrictEqual({ status: SUCCESS });
    });
  });

  describe('when request is failure', () => {
    beforeAll(() => {
      axiosResult = { data: { errors: {} }, status: 400 };
    });

    it('should call makeMultipleDeleteRequest', () => {
      expect(makeMultipleDeleteRequest).toHaveBeenCalledTimes(1);
    });

    it('should return ERROR status', () => {
      expect(result).toStrictEqual({ message: '', status: ERROR });
    });
  });
});
