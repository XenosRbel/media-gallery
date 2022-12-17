import React from 'react';
import PropTypes from 'prop-types';

const Link = ({ label, path, ...props }) =>
  path ? (
    <a href={path} {...props}>
      {label}
    </a>
  ) : null;

Link.propTypes = {
  label: PropTypes.string.isRequired,
  path: PropTypes.string.isRequired,
};

export default Link;
