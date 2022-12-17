import React from 'react';
import PropTypes from 'prop-types';

import Errors from '../errors/Errors';
import { sanitizeAttributeName } from '../utils';
import { Input } from 'antd';

const InputField = ({ className, id, name, onChange, value, disabled, translateAttribute, placeholder }) => (
  <div className={className}>
    <label htmlFor={id}>{translateAttribute(sanitizeAttributeName(name))}</label>
    <input id={id} name={name} onChange={onChange} value={value} disabled={disabled} placeholder={placeholder} />
    <Errors attribute={name} />
  </div>
);

InputField.propTypes = {
  className: PropTypes.string,
  disabled: PropTypes.bool,
  id: PropTypes.string,
  name: PropTypes.string,
  onChange: PropTypes.func.isRequired,
  placeholder: PropTypes.string,
  translateAttribute: PropTypes.func.isRequired,
  value: PropTypes.string,
};

InputField.defaultProps = {
  className: '',
  disabled: false,
  id: '',
  name: '',
  placeholder: '',
  value: '',
};

export default InputField;
