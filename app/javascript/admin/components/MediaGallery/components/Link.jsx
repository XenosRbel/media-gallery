import React from 'react';
import PropTypes from 'prop-types';
import { Button  } from 'antd';

const Link = ({ path, iconName, label, onClick }) => (
  <Button className="button tiny action-button" href={path} onClick={onClick}>
    <span>
      {label} <i className={`fa fa-${iconName}`} />
    </span>
  </Button>

);

Link.propTypes = {
  iconName: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired,
  onClick: PropTypes.func,
  path: PropTypes.string,
};

Link.defaultProps = {
  onClick: null,
  path: '#',
};

export default Link;
