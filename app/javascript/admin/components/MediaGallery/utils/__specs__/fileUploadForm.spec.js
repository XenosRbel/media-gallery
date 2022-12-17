import { getDefaultGroupOption, handleSubmitFile } from '../fileUploadForm';
import httpUtils, { sendDataRequest } from '../../../../../front/utils/http';

describe('Utility: getDefaultGroupOption', () => {
  const result = (folderOptions) => getDefaultGroupOption(folderOptions);

  describe('when default folder exists in folder options', () => {
    const folderOptions = [
      { label: 'General', value: 1 },
      { label: 'A', value: 2 },
    ];

    it('should return these default folder oprion', () => {
      expect(result(folderOptions)).toStrictEqual({ label: 'General', value: 1 });
    });
  });

  describe('when default folder does not exist in folder options', () => {
    const folderOptions = [{ label: 'A', value: 1 }];

    it('should return this empty hash', () => {
      expect(result(folderOptions)).toStrictEqual({});
    });
  });
});

jest.mock('../../../../../front/utils/http', () => ({
  ...jest.requireActual('../../../../../front/utils/http'),
  sendDataRequest: jest.fn(),
}));

describe('Utility: handleSubmitFile', () => {
  const onSuccessSpy = jest.fn();
  const onErrorSpy = jest.fn();

  const params = {
    file: {},
    onError: onErrorSpy,
    onSuccess: onSuccessSpy,
  };
  const folderId = 1;
  const formUrl = 'http://example.example/path';

  let axiosResult;

  httpUtils.sendDataRequest.mockImplementation(() => Promise.resolve(axiosResult));

  beforeEach(async () => {
    await handleSubmitFile(params, formUrl, folderId);
  });

  describe('when request is successful', () => {
    beforeAll(() => {
      axiosResult = { data: {}, status: 200 };
    });

    it('should call sendDataRequest', () => {
      expect(sendDataRequest).toHaveBeenCalledTimes(1);
    });

    it('should call onSuccess', () => {
      expect(onSuccessSpy).toHaveBeenCalledTimes(1);
    });

    it('should not call onError', () => {
      expect(onErrorSpy).toHaveBeenCalledTimes(0);
    });
  });

  describe('when request is failure', () => {
    beforeAll(() => {
      axiosResult = { data: {}, status: 400 };
    });

    it('should call sendDataRequest', () => {
      expect(sendDataRequest).toHaveBeenCalledTimes(1);
    });

    it('should not call onSuccess', () => {
      expect(onSuccessSpy).toHaveBeenCalledTimes(0);
    });

    it('should call onError', () => {
      expect(onErrorSpy).toHaveBeenCalledTimes(1);
    });
  });
});
