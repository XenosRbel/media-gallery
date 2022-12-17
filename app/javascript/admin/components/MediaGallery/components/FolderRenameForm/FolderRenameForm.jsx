import React, { useState, useCallback } from 'react';
import PropTypes from 'prop-types';
import { Row, Button } from 'antd';
import snakeize from 'snakeize';

import { translateAttribute, TRANSLATE_SAVE_GROUP, TRANSLATE_INPUT_PLACEHOLDER } from './utils';
import { getInputProps, submitForm } from '../../../common/utils';
import { ErrorsContextProvider } from '../../../common/errors/ErrorsContext';
import InputField from '../../../common/inputs/InputField';
import { PUT_HTTP_METHOD } from '../../constants/common';

const FolderRenameForm = ({ folderAttr, handleCloseForm, handleLoadGalleryItems, handleErrorViaAlertBox }) => {
  const [errors, setErrors] = useState({});
  const [folder, setFolder] = useState(folderAttr.folder);

  const handleAttributeChange = useCallback(({ target: { name, value } }) => {
    setFolder((prevFolder) => ({ ...prevFolder, [name]: value }));
  }, []);

  const handleSubmitFolder = useCallback(
    async (event) => {
      event.preventDefault();

      try {
        await submitForm(PUT_HTTP_METHOD, folderAttr.path, { ...snakeize(folder) }, 'folder');

        handleLoadGalleryItems();
        handleCloseForm(false);
      } catch (error) {
        if (error.response.data === String || error.response.data === '') {
          handleErrorViaAlertBox({ data: error.response.data, method: PUT_HTTP_METHOD, status: error.response.status });
        } else {
          const {
            response: {
              data: { errors: errorMessages },
            },
          } = error;

          setErrors(errorMessages);
        }
      }
    },
    [folderAttr.path, folder, handleLoadGalleryItems, handleCloseForm, handleErrorViaAlertBox],
  );

  return (
    <form className="media-gallery-folder-form">
      <ErrorsContextProvider value={errors}>
        <Row>
          <InputField
            {...getInputProps('name', handleAttributeChange, folder, translateAttribute)}
            placeholder={TRANSLATE_INPUT_PLACEHOLDER}
          />
        </Row>
        <Row align="middle" justify="space-around">
          <Button className="button success tiny" htmlType="submit" onClick={handleSubmitFolder} size="small">
            <span>{TRANSLATE_SAVE_GROUP}</span>
          </Button>
        </Row>
      </ErrorsContextProvider>
    </form>
  );
};

FolderRenameForm.propTypes = {
  folderAttr: PropTypes.shape({
    folder: PropTypes.shape({
      name: PropTypes.string.isRequired,
      systemName: PropTypes.string.isRequired,
    }),
    path: PropTypes.string,
  }),
  handleCloseForm: PropTypes.func.isRequired,
  handleErrorViaAlertBox: PropTypes.func.isRequired,
  handleLoadGalleryItems: PropTypes.func.isRequired,
};

FolderRenameForm.defaultProps = {
  folderAttr: {
    folder: {
      name: '',
      systemName: '',
    },
    path: '',
  },
};

export default FolderRenameForm;
