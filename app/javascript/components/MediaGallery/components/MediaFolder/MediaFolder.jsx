import React, { useContext, useCallback } from 'react';
import PropTypes from 'prop-types';
import { Upload, Row, Col, Checkbox } from 'antd';

import { handleSubmitFile } from '../../utils/fileUploadForm';
import { MediaGalleryContext } from '../MediaGalleryContext';
import { POST_HTTP_METHOD, DEFAULT_SYSTEM_GROUP_NAME, SUCCESS } from '../../constants/common';
import { fileShape } from '../../data/shapes';
import {
  FILE_UPLOAD_STATUS_DONE,
  FILE_UPLOAD_STATUS_ERROR,
  ROW_GUTTER,
  FIRST_ITEM_INDEX,
} from '../../constants/mediaFolder';

const MediaFolder = ({ filesPath, groupId, files, groupSystemName }) => {
  const { handleError, handleLoadGalleryItems, handleSelectFile, fileIds } = useContext(MediaGalleryContext);

  const handleChange = ({ file, file: { status } }) => {
    switch (status) {
      case FILE_UPLOAD_STATUS_DONE:
        handleLoadGalleryItems();
        handleError({ data: SUCCESS, method: POST_HTTP_METHOD, status });
        break;
      case FILE_UPLOAD_STATUS_ERROR: {
        const {
          error: { statusText },
        } = file;

        handleError({ data: statusText, method: POST_HTTP_METHOD, status });
        break;
      }

      default:
        break;
    }
  };

  const handleCheckFileClick = useCallback(
    (fileId) => ({ target: { checked } }) => {
      const newFileIds = checked ? [...fileIds.current, fileId] : _.without(fileIds.current, fileId);

      fileIds.current = newFileIds;
    },
    [fileIds],
  );

  const handleFirstItemDefaultGroup = (itemIndex, fileId) => {
    if (
      groupSystemName === DEFAULT_SYSTEM_GROUP_NAME &&
      itemIndex === FIRST_ITEM_INDEX &&
      fileIds.current.length === 0
    ) {
      fileIds.current = [...fileIds.current, fileId];

      return true;
    }

    return false;
  };

  return (
    <Row key={`group-${groupId}`} gutter={ROW_GUTTER}>
      {files.map(({ id, thumbnailImage, name, originalImage, ...file }, index) => (
        <Col key={`item-${id}`} md={4} className="center word-wrap">
          <Checkbox
            className="top-left"
            onChange={handleCheckFileClick(id)}
            defaultChecked={handleFirstItemDefaultGroup(index, id)}
          />
          <img
            aria-hidden="true"
            key={id}
            src={thumbnailImage}
            alt={name}
            onClick={() => handleSelectFile({ id, name, originalImage, thumbnailImage, ...file })}
          />
          <br />
          <span variant="small">{originalImage.split('/').pop()}</span>
        </Col>
      ))}
      <Col key="upload-form" md={4} className="center">
        <Upload
          listType="picture-card"
          showUploadList={false}
          customRequest={(params) => handleSubmitFile(params, filesPath, groupId)}
          onChange={handleChange}
        >
          <i className="fa fa-plus fa-2x" aria-hidden="true" />
        </Upload>
      </Col>
    </Row>
  );
};

MediaFolder.propTypes = {
  files: PropTypes.arrayOf(fileShape),
  filesPath: PropTypes.string.isRequired,
  groupId: PropTypes.string,
  groupSystemName: PropTypes.string,
};

MediaFolder.defaultProps = {
  files: [],
  groupId: '',
  groupSystemName: '',
};

export default MediaFolder;
