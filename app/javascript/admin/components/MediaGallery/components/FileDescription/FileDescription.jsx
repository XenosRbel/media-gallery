import React, { useState, useCallback, useEffect } from 'react';
import PropTypes from 'prop-types';
import { Row, Col, Button, message, Input, Upload } from 'antd';
import { CopyToClipboard } from 'react-copy-to-clipboard';

import InputField from '../../../common/inputs/InputField';
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
import { sendDataRequest } from '../../../../../front/utils/http';
import DocViewer, {
  BMPRenderer,
  HTMLRenderer,
  JPGRenderer,
  MSDocRenderer,
  MSGRenderer,
  PDFRenderer,
  PNGRenderer,
  TIFFRenderer,
  TXTRenderer
} from "react-doc-viewer";
import VideoRenderer from './VideoRenderer'

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

  const { id, name, folderName, width, height, filesize, url } = file;

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
    <div className='file-description'>
      <DocViewer
        className="center"
        alt={name}
        pluginRenderers={[
          BMPRenderer,
          HTMLRenderer,
          JPGRenderer,
          MSDocRenderer,
          MSGRenderer,
          PDFRenderer,
          PNGRenderer,
          TIFFRenderer,
          TXTRenderer,
          VideoRenderer]}
        config={
          {
            header: {
             disableHeader: true,
             disableFileName: false,
             retainURLParams: false
            }
           }
        }
        documents={[ {uri: url }]}
      />

      <LabelForAttribute name="name" value={name} />

      <LabelForAttribute name="folderName" value={folderName} />

      <LabelForAttribute name="width" value={width} />

      <LabelForAttribute name="height" value={height} />

      <LabelForAttribute name="filesize" value={formatFileSize(filesize)} />

      <Input
        className="attribute"
        value={url}
        suffix={
          <CopyToClipboard onCopy={onCopy} text={url}>
            <span className="ant-btn ant-btn-icon-only">
              <i className="fa fa-clipboard copy-icon" aria-hidden="true" />
            </span>
          </CopyToClipboard>
        }
      />

      <form className="media-gallery-folder-form">
        <div>
          <InputField
            {...getInputProps('description', handleAttributeChange, file, translateFileAttribute)}
            className="ant-col attribute"
            placeholder={TRANSLATE_FILE_DESCRIPTION_PLACEHOLDER}
          />
        </div>
        <Row gutter={ROW_GUTTER_SIZE} className='actions'>
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
  galleryFile: PropTypes.shape(fileShape),
  handleCloseFileDescription: PropTypes.func.isRequired,
  handleLoadGalleryItems: PropTypes.func.isRequired,
  handleResponseMessage: PropTypes.func.isRequired,
};

FileDescription.defaultProps = {
  galleryFile: {
    description: '',
    filesize: 0,
    folderId: 0,
    folderName: '',
    height: 0,
    id: 0,
    name: '',
    originalImage: '',
    thumbnailImage: '',
    url: '',
    width: 0,
  }
};

export default FileDescription;
