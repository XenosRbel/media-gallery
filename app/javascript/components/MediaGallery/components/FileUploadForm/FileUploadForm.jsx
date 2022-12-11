import React, { useState, useCallback } from 'react';
import PropTypes from 'prop-types';
import { Form, Upload, message } from 'antd';
import Select from 'react-select';

import {
  TRANSLATE_GROUP_NAME_PLACEHOLDER,
  TRANSLATE_UPLOAD_FORM_TEXT,
  TRANSLATE_UPLOAD_FORM_HINT,
  NUMBER_OF_AVAILABLE_FILES,
  TRANSLATE_FILE_SUCCESS,
} from '../../constants/fileUploadForm';
import { getDefaultGroupOption, handleSubmitFile } from '../../utils/fileUploadForm';
import { groupOptionShape } from '../../data/shapes';
import { FILE_UPLOAD_STATUS_DONE } from '../../constants/mediaFolder';

const FileUploadForm = ({ formUrl, selectGroupOptions }) => {
  const [group, setGroup] = useState(getDefaultGroupOption(selectGroupOptions));

  const handleUploadChange = useCallback(({ fileList }) => fileList, []);

  const handleUploaderChange = ({ file: { status, name } }) => {
    switch (status) {
      case FILE_UPLOAD_STATUS_DONE:
        message.success(`${name} ${TRANSLATE_FILE_SUCCESS}`);
        break;
      default:
        break;
    }
  };

  return (
    <Form className="upload-form">
      <div justify="space-around">
        <Form.Item>
          <Select
            value={group}
            name="mediaGalleryGroupId"
            onChange={setGroup}
            options={selectGroupOptions}
            searchable={false}
            clearable={false}
            placeholder={TRANSLATE_GROUP_NAME_PLACEHOLDER}
          />
        </Form.Item>
        <Form.Item name="files" getValueFromEvent={handleUploadChange} valuePropName="fileList">
          <Upload.Dragger
            multiple
            maxCount={NUMBER_OF_AVAILABLE_FILES}
            customRequest={(params) => handleSubmitFile(params, formUrl, group.value)}
            onChange={handleUploaderChange}
            showUploadList={{ showPreviewIcon: true, showRemoveIcon: true }}
          >
            <i className="fa fa-folder-open" />
            <div>
              <p className="antd-upload-text">{TRANSLATE_UPLOAD_FORM_TEXT}</p>
              <p className="antd-upload-hint">{TRANSLATE_UPLOAD_FORM_HINT}</p>
            </div>
          </Upload.Dragger>
        </Form.Item>
      </div>
    </Form>
  );
};

FileUploadForm.propTypes = {
  formUrl: PropTypes.string.isRequired,
  selectGroupOptions: PropTypes.arrayOf(groupOptionShape).isRequired,
};

export default FileUploadForm;
