import React, { useState, useCallback, useEffect } from 'react';
import PropTypes from 'prop-types';
import { Row, Col, Button, message, Input, Upload } from 'antd';
import { CopyToClipboard } from 'react-copy-to-clipboard';

import InputField from '../../../inputs/InputField';
import { getInputProps, formatFileSize } from '../../../common/utils';
import { PUT_HTTP_METHOD, SUCCESS } from '../../constants/common';
import { fileShape } from '../../data/shapes';
import { translateFileAttribute, getErrorStatusByErrorCode, handleDeleteFilesByIds } from '../../utils/common';
import {
  TRANSLATE_FILE_DESCRIPTION_PLACEHOLDER,
  TRANSLATE_DELETE_ACTION,
  TRANSLATE_SAVE_ACTION,
  TRANSLATE_REPLACE_ACTION,
  ROW_GUTTER_SIZE,
  TRANSLATE_URL_COPIED,
  TRANSLATE_FILE_ATTACHED,
} from '../../constants/fileDescription';
import { buildFormData } from '../../utils/fileUploadForm';
import LabelForAttribute from './LabelForAttribute';
import { sendDataRequest } from '../../../common/http';

const showInfoMessage = message.info;
const onCopy = () => showInfoMessage(TRANSLATE_URL_COPIED);

function getBase64(file) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();

    reader.readAsDataURL(file);
    reader.onload = () => resolve(reader.result);
    reader.onerror = (error) => reject(error);
  });
}

const FileDescription = ({
  galleryFile,
  filesPath,
  handleCloseFileDescription,
  handleLoadGalleryItems,
  handleResponseMessage,
}) => {
  const [file, setFile] = useState({});
  const [newFile, setNewFile] = useState(null);
  const [originalImage, setOriginalImage] = useState();

  const { id, name, groupName, width, height, filesize, url } = file;

  const handleAttributeChange = useCallback(({ target: { name: attribute, value } }) => {
    setFile((prevFile) => ({ ...prevFile, [attribute]: value }));
  }, []);

  const handleBeforeUpload = useCallback(async (currentNewFile) => {
    setNewFile(currentNewFile);

    setOriginalImage(await getBase64(currentNewFile));

    showInfoMessage(TRANSLATE_FILE_ATTACHED);

    return false;
  }, []);

  const handleSubmit = useCallback(async () => {
    const formData = buildFormData({ file: newFile, ...file });

    const data = await sendDataRequest(PUT_HTTP_METHOD, `${filesPath}/${id}`, formData);

    const requestStatus = getErrorStatusByErrorCode(data.status);

    if (requestStatus === SUCCESS) {
      handleCloseFileDescription();
      handleLoadGalleryItems();
    }

    handleResponseMessage(data);
  }, [file, filesPath, handleCloseFileDescription, handleResponseMessage, handleLoadGalleryItems, id, newFile]);

  const handleSubmitDeleteFile = useCallback(async () => {
    const { status } = await handleDeleteFilesByIds(filesPath, id, 'id');

    if (status === SUCCESS) {
      handleCloseFileDescription();
      handleLoadGalleryItems();
    }
  }, [filesPath, handleCloseFileDescription, handleLoadGalleryItems, id]);

  useEffect(() => {
    setFile(galleryFile);
    setOriginalImage(galleryFile.originalImage);
  }, [galleryFile]);

  return (
    <div>
      <img className="center" src={originalImage} alt={name} />

      <LabelForAttribute name="name" value={name} />

      <LabelForAttribute name="groupName" value={groupName} />

      <LabelForAttribute name="width" value={width} />

      <LabelForAttribute name="height" value={height} />

      <LabelForAttribute name="filesize" value={formatFileSize(filesize)} />

      <Input
        value={url}
        suffix={
          <CopyToClipboard onCopy={onCopy} text={url}>
            <span className="antd-btn antd-btn-icon-only">
              <i className="fa fa-clipboard copy-icon" aria-hidden="true" />
            </span>
          </CopyToClipboard>
        }
      />

      <form className="media-gallery-group-form">
        <div>
          <InputField
            {...getInputProps('description', handleAttributeChange, file, translateFileAttribute)}
            className="antd-col"
            placeholder={TRANSLATE_FILE_DESCRIPTION_PLACEHOLDER}
          />
        </div>
        <Row gutter={ROW_GUTTER_SIZE}>
          <Col>
            <Button size="small" onClick={handleSubmitDeleteFile}>
              {TRANSLATE_DELETE_ACTION}
            </Button>
          </Col>
          <Col>
            <Upload showUploadList={false} beforeUpload={handleBeforeUpload} onChange={null}>
              <Button size="small">{TRANSLATE_REPLACE_ACTION}</Button>
            </Upload>
          </Col>
          <Col>
            <Button size="small" onClick={handleSubmit}>
              {TRANSLATE_SAVE_ACTION}
            </Button>
          </Col>
        </Row>
      </form>
    </div>
  );
};

FileDescription.propTypes = {
  filesPath: PropTypes.string.isRequired,
  galleryFile: PropTypes.shape(fileShape).isRequired,
  handleCloseFileDescription: PropTypes.func.isRequired,
  handleLoadGalleryItems: PropTypes.func.isRequired,
  handleResponseMessage: PropTypes.func.isRequired,
};

export default FileDescription;
