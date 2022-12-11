import React, { useState, useCallback } from 'react';
import PropTypes from 'prop-types';
import { Row, Button } from 'antd';
import snakeize from 'snakeize';

import { translateAttribute, TRANSLATE_SAVE_GROUP, TRANSLATE_INPUT_PLACEHOLDER } from './utils';
import { getInputProps, submitForm } from '../../../common/utils';
import { ErrorsContextProvider } from '../../../common/errors/ErrorsContext';
import InputField from '../../../inputs/InputField';
import { PUT_HTTP_METHOD } from '../../constants/common';

const GroupRenameForm = ({ groupAttr, handleCloseForm, handleLoadGalleryItems, handleErrorViaAlertBox }) => {
  const [errors, setErrors] = useState({});
  const [group, setGroup] = useState(groupAttr.group);

  const handleAttributeChange = useCallback(({ target: { name, value } }) => {
    setGroup((prevGroup) => ({ ...prevGroup, [name]: value }));
  }, []);

  const handleSubmitGroup = useCallback(
    async (event) => {
      event.preventDefault();

      try {
        await submitForm(PUT_HTTP_METHOD, groupAttr.path, { ...snakeize(group) }, 'group');

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
    [groupAttr.path, group, handleLoadGalleryItems, handleCloseForm, handleErrorViaAlertBox],
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
        <Row align="middle" justify="space-around">
          <Button className="button success tiny" htmlType="submit" onClick={handleSubmitGroup} size="small">
            <span>{TRANSLATE_SAVE_GROUP}</span>
          </Button>
        </Row>
      </ErrorsContextProvider>
    </form>
  );
};

GroupRenameForm.propTypes = {
  groupAttr: PropTypes.shape({
    group: PropTypes.shape({
      name: PropTypes.string.isRequired,
      systemName: PropTypes.string.isRequired,
    }),
    path: PropTypes.string,
  }),
  handleCloseForm: PropTypes.func.isRequired,
  handleErrorViaAlertBox: PropTypes.func.isRequired,
  handleLoadGalleryItems: PropTypes.func.isRequired,
};

GroupRenameForm.defaultProps = {
  groupAttr: {
    group: {
      name: '',
      systemName: '',
    },
    path: '',
  },
};

export default GroupRenameForm;
