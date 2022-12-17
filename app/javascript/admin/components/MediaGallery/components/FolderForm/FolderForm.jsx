import React, { useState, useCallback } from 'react';
import PropTypes from 'prop-types';
import { Row, Button } from 'antd';

import { getInputProps, submitForm } from '../../../common/utils';
import { translateAttribute, TRANSLATE_ADD_GROUP, TRANSLATE_INPUT_PLACEHOLDER } from './utils';
import { ErrorsContextProvider } from '../../../common/errors/ErrorsContext';
import InputField from '../../../common/inputs/InputField';

const FolderForm = ({ createFolderSubmitPath, handleCreateFolder, httpMethod }) => {
  const [errors, setErrors] = useState({});
  const [folder, setFolder] = useState({});

  const handleAttributeChange = useCallback(({ target: { name, value } }) => {
    setFolder((prevFolder) => ({ ...prevFolder, [name]: value }));
  }, []);

  const handleSubmitFolder = useCallback(
    async (event) => {
      event.preventDefault();

      try {
        await submitForm(httpMethod, createFolderSubmitPath, { ...folder }, 'folder');

        handleCreateFolder();
      } catch (error) {
        const {
          response: {
            data: { errors: errorMessages },
          },
        } = error;

        setErrors(errorMessages);
      }
    },
    [createFolderSubmitPath, folder, handleCreateFolder, httpMethod],
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
        <Row>
          <InputField
            {...getInputProps('system_name', handleAttributeChange, folder, translateAttribute)}
            placeholder={TRANSLATE_INPUT_PLACEHOLDER}
          />
        </Row>
        <Row align="middle" justify="space-around">
          <Button className="button success tiny" htmlType="submit" onClick={handleSubmitFolder} size="small">
            <span>{TRANSLATE_ADD_GROUP}</span>
          </Button>
        </Row>
      </ErrorsContextProvider>
    </form>
  );
};

FolderForm.propTypes = {
  createFolderSubmitPath: PropTypes.string.isRequired,
  handleCreateFolder: PropTypes.func.isRequired,
  httpMethod: PropTypes.string.isRequired,
};

export default FolderForm;
