import React from 'react';
import PropTypes from 'prop-types';
import { CKEditor } from 'ckeditor4-react';

import Errors from '../common/errors/Errors';
import { sanitizeAttributeName } from '../common/utils';

const CKEditorInputField = ({ className, id, name, config, onChange, value, readOnly, translateAttribute, type }) => (
  <div className={className}>
    <label htmlFor={id}>{translateAttribute(sanitizeAttributeName(name))}</label>
    <CKEditor
      id={id}
      name={name}
      initData={value}
      readOnly={readOnly}
      type={type}
      config={config}
      onChange={onChange}
    />
    <Errors attribute={name} />
  </div>
);

CKEditorInputField.propTypes = {
  className: PropTypes.string,
  config: PropTypes.objectOf(PropTypes.object),
  id: PropTypes.string,
  name: PropTypes.string,
  onChange: PropTypes.func.isRequired,
  readOnly: PropTypes.bool,
  translateAttribute: PropTypes.func.isRequired,
  type: PropTypes.string,
  value: PropTypes.string,
};

CKEditorInputField.defaultProps = {
  className: '',
  config: {},
  id: '',
  name: '',
  readOnly: false,
  type: 'classic',
  value: '',
};

export default CKEditorInputField;
