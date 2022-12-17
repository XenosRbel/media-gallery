import React, { useCallback } from 'react';
import PropTypes from 'prop-types';
import { Row, Col } from 'antd';

import Link from '../Link';
import { TRANSLATE_UPLOAD_FILE, TRANSLATE_CREATE_GROUP, TRANSLATE_REMOVE_SELECTED } from '../../constants/actionBar';

const ActionBar = ({ handleFolderCreateClick, handleVisibleModalUploadFile, handleRemoveSelectedFiles }) => {
  const handleUploadFileModalShow = useCallback(() => {
    handleVisibleModalUploadFile(true);
  }, [handleVisibleModalUploadFile]);

  return (
    <Col>
      <Row className="accordion-navigation">
        <Col>
          <Link label={TRANSLATE_UPLOAD_FILE} iconName="cloud-upload" onClick={handleUploadFileModalShow} />
          <Link label={TRANSLATE_CREATE_GROUP} iconName="pencil" onClick={handleFolderCreateClick} />
          <Link label={TRANSLATE_REMOVE_SELECTED} iconName="trash" onClick={handleRemoveSelectedFiles} />
        </Col>
      </Row>
    </Col>
  );
};

ActionBar.propTypes = {
  handleFolderCreateClick: PropTypes.func.isRequired,
  handleRemoveSelectedFiles: PropTypes.func.isRequired,
  handleVisibleModalUploadFile: PropTypes.func.isRequired,
};

export default ActionBar;
