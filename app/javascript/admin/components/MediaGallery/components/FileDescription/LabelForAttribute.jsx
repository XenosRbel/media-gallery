import React from 'react';
import PropTypes from 'prop-types';

import { sanitizeAttributeName } from '../../../common/utils';
import { translateFileAttribute } from '../../utils/common';

const LabelForAttribute = ({ name, value }) => (
  <div className='attribute'>
    <span variant="small">{translateFileAttribute(sanitizeAttributeName(name))}</span>
    <span>: </span>
    <span variant="small">{value}</span>
  </div>
);

LabelForAttribute.propTypes = {
  name: PropTypes.string,
  value: PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
};

LabelForAttribute.defaultProps = {
  name: '',
  value: '',
};

export default LabelForAttribute;
