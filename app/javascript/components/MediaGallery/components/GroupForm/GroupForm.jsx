import React, { useState, useCallback } from 'react';
import PropTypes from 'prop-types';
import { Row, Button } from 'antd';

import { getInputProps, submitForm } from '../../../common/utils';
import { translateAttribute, TRANSLATE_ADD_GROUP, TRANSLATE_INPUT_PLACEHOLDER } from './utils';
import { ErrorsContextProvider } from '../../../common/errors/ErrorsContext';
import InputField from '../../../inputs/InputField';

const GroupForm = ({ createGroupSubmitPath, handleCreateGroup, httpMethod }) => {
  const [errors, setErrors] = useState({});
  const [group, setGroup] = useState({});

  const handleAttributeChange = useCallback(({ target: { name, value } }) => {
    setGroup((prevGroup) => ({ ...prevGroup, [name]: value }));
  }, []);

  const handleSubmitGroup = useCallback(
    async (event) => {
      event.preventDefault();

      try {
        await submitForm(httpMethod, createGroupSubmitPath, { ...group }, 'group');

        handleCreateGroup();
      } catch (error) {
        const {
          response: {
            data: { errors: errorMessages },
          },
        } = error;

        setErrors(errorMessages);
      }
    },
    [createGroupSubmitPath, group, handleCreateGroup, httpMethod],
  );

  return (
    <form className="media-gallery-group-form">
      <ErrorsContextProvider value={errors}>
        <Row>
          <InputField
            {...getInputProps('name', handleAttributeChange, group, translateAttribute)}
            placeholder={TRANSLATE_INPUT_PLACEHOLDER}
          />
        </Row>
        <Row>
          <InputField
            {...getInputProps('system_name', handleAttributeChange, group, translateAttribute)}
            placeholder={TRANSLATE_INPUT_PLACEHOLDER}
          />
        </Row>
        <Row align="middle" justify="space-around">
          <Button className="button success tiny" htmlType="submit" onClick={handleSubmitGroup} size="small">
            <span>{TRANSLATE_ADD_GROUP}</span>
          </Button>
        </Row>
      </ErrorsContextProvider>
    </form>
  );
};

GroupForm.propTypes = {
  createGroupSubmitPath: PropTypes.string.isRequired,
  handleCreateGroup: PropTypes.func.isRequired,
  httpMethod: PropTypes.string.isRequired,
};

export default GroupForm;
