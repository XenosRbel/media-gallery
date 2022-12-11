import React from 'react';
import PropTypes from 'prop-types';
import {Button} from 'antd'

const Link = ({ path, iconName, label, onClick }) => (
  <a className="button tiny action-button nav-link" href={path} onClick={onClick}>
    <Button>
      {label} <i className={`fa fa-${iconName}`} />
    </Button>
  </a>
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
