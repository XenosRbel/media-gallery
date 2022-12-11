import React from 'react';
import PropTypes from 'prop-types';
import Errors from '../common/errors/Errors';
import AsyncSelect from './AsyncSelect';
import { sanitizeAttributeName } from '../common/utils';
import { optionsShape } from '../data/shapes';

const AsyncSelectField = ({
  className,
  id,
  name,
  onChange,
  remoteUrl,
  inputLengthToFetch,
  initialValue,
  disabled,
  translateAttribute,
}) => (
  <div className={className}>
    <label htmlFor={id}>
      { translateAttribute(sanitizeAttributeName(name)) }
    </label>
    <AsyncSelect
      id={id}
      name={name}
      onChange={onChange}
      remoteUrl={remoteUrl}
      inputLengthToFetch={inputLengthToFetch}
      initialValue={initialValue}
      disabled={disabled}
      searchable
    />
    <Errors attribute={name} />
  </div>
);

AsyncSelectField.propTypes = {
  onChange: PropTypes.func.isRequired,
  remoteUrl: PropTypes.string.isRequired,
  id: PropTypes.string,
  name: PropTypes.string,
  className: PropTypes.string,
  inputLengthToFetch: PropTypes.number,
  initialValue: optionsShape,
  disabled: PropTypes.bool,
  translateAttribute: PropTypes.func.isRequired,
};

AsyncSelectField.defaultProps = {
  id: '',
  name: '',
  className: '',
  inputLengthToFetch: 3,
  initialValue: {
    label: '',
    value: '',
  },
  disabled: false,
};

export default AsyncSelectField;
