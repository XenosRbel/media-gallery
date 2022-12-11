import React from 'react';
import PropTypes from 'prop-types';
import { sanitizeAttributeName } from '../common/utils';

const Checkbox = ({ className, id, name, value, onChange, translateAttribute, label, disabled }) => (
  <div className={className}>
    {
      label && (
        <label htmlFor={id}>
          { translateAttribute ? translateAttribute(sanitizeAttributeName(name)) : name }
        </label>
      )
    }
    <input id={id} name={name} type="checkbox" checked={value} onChange={onChange} disabled={disabled} />
  </div>
);

Checkbox.propTypes = {
  className: PropTypes.string,
  id: PropTypes.string,
  name: PropTypes.string,
  value: PropTypes.bool.isRequired,
  onChange: PropTypes.func.isRequired,
  translateAttribute: PropTypes.func,
  label: PropTypes.bool,
  disabled: PropTypes.bool,
};

Checkbox.defaultProps = {
  className: '',
  id: '',
  name: '',
  translateAttribute: null,
  label: false,
  disabled: false,
};

export default Checkbox;
