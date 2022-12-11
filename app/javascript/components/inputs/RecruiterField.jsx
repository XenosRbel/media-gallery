import React, { useEffect, useMemo } from 'react';
import PropTypes from 'prop-types';
import SelectField from './SelectField';
import { optionsShape } from '../data/shapes';

const RecruiterField = ({ currentUser, onChange, value, options, ...selectProps }) => {
  useEffect(() => {
    if (currentUser.isHr) onChange(currentUser);
  }, [currentUser, onChange, value]);

  const selectOptions = useMemo(() => (currentUser.isHr ? [currentUser] : options), [currentUser, options]);

  return (
    <SelectField
      {...selectProps}
      value={value}
      onChange={onChange}
      disabled={currentUser.isHr}
      clearable={!currentUser.isHr}
      options={selectOptions}
    />
  );
};

RecruiterField.propTypes = {
  onChange: PropTypes.func.isRequired,
  currentUser: PropTypes.shape({
    label: PropTypes.string.isRequired,
    value: PropTypes.number.isRequired,
    isHr: PropTypes.bool.isRequired,
  }).isRequired,
  options: PropTypes.arrayOf(optionsShape),
  value: PropTypes.number,
  translateAttribute: PropTypes.func.isRequired,
};

RecruiterField.defaultProps = {
  value: null,
  options: [],
};

export default RecruiterField;
