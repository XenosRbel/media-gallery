import React from 'react';
import PropTypes from 'prop-types';
import Errors from '../common/errors/Errors';

const TextAreaField = ({ className, id, name, onChange, value, translateAttribute }) => (
  <div className={className}>
    <label htmlFor={id}>
      { translateAttribute(name) }
    </label>
    <textarea id={id} name={name} onChange={onChange} value={value} />
    <Errors attribute={name} />
  </div>
);

TextAreaField.propTypes = {
  onChange: PropTypes.func.isRequired,
  id: PropTypes.string,
  name: PropTypes.string,
  className: PropTypes.string,
  value: PropTypes.string,
  translateAttribute: PropTypes.func.isRequired,
};

TextAreaField.defaultProps = {
  id: '',
  name: '',
  className: '',
  value: '',
};

export default TextAreaField;
