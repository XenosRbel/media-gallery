import React from 'react';
import PropTypes from 'prop-types';
import ReactSelect from 'react-select';
import Errors from '../common/errors/Errors';
import { sanitizeAttributeName } from '../common/utils';
import { SELECT_PLACEHOLDER } from '../constants';
import { optionsShape } from '../data/shapes';

const SelectField = ({ className, id, name, disabled, translateAttribute, ...selectProps }) => (
  <div className={className}>
    <label htmlFor={id}>
      { translateAttribute(sanitizeAttributeName(name)) }
    </label>
    <ReactSelect
      {...selectProps}
      id={id}
      name={name}
      placeholder={SELECT_PLACEHOLDER}
      disabled={disabled}
    />
    <Errors attribute={name} />
  </div>
);

SelectField.propTypes = {
  onChange: PropTypes.func.isRequired,
  value: PropTypes.oneOfType([PropTypes.string, PropTypes.number, optionsShape]),
  options: PropTypes.arrayOf(optionsShape).isRequired,
  id: PropTypes.string,
  name: PropTypes.string,
  isLoading: PropTypes.bool,
  searchable: PropTypes.bool,
  className: PropTypes.string,
  disabled: PropTypes.bool,
  translateAttribute: PropTypes.func.isRequired,
};

SelectField.defaultProps = {
  value: null,
  id: '',
  name: '',
  isLoading: false,
  searchable: false,
  className: '',
  disabled: false,
};

export default SelectField;
