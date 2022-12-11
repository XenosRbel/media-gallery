import React, { useCallback } from 'react';
import PropTypes from 'prop-types';
import { Row, Col } from 'antd';

import Link from '../Link';
import { TRANSLATE_UPLOAD_FILE, TRANSLATE_CREATE_GROUP, TRANSLATE_REMOVE_SELECTED } from '../../constants/actionBar';

const ActionBar = ({ handleGroupCreateClick, handleVisibleModalUploadFile, handleRemoveSelectedFiles }) => {
  const handleUploadFileModalShow = useCallback(() => {
    handleVisibleModalUploadFile(true);
  }, [handleVisibleModalUploadFile]);

  return (
    <Col>
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
          <Row className="collapse navbar-collapse" id="navbarNavAltMarkup">
            <Col className='navbar-nav'>
              <Link label={TRANSLATE_UPLOAD_FILE} iconName="cloud-upload" onClick={handleUploadFileModalShow} />
              <Link label={TRANSLATE_CREATE_GROUP} iconName="pencil" onClick={handleGroupCreateClick} />
              <Link label={TRANSLATE_REMOVE_SELECTED} iconName="trash" onClick={handleRemoveSelectedFiles} />
            </Col>
          </Row>
        </div>
      </nav>
    </Col>
  );
};

ActionBar.propTypes = {
  handleGroupCreateClick: PropTypes.func.isRequired,
  handleRemoveSelectedFiles: PropTypes.func.isRequired,
  handleVisibleModalUploadFile: PropTypes.func.isRequired,
};

export default ActionBar;
