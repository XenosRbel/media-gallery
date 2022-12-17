import React from 'react';
import PropTypes from 'prop-types';

import { CONFIRM_ATTRIBUTE_TRANSLATION } from './translations';

const Actions = ({ original }) => {
  const {
    links: { editPath, deletePath },
  } = original;

  return (
    <div className="table-actions center">
      {editPath && (
        <a className="action-item" href={editPath}>
          <i className="fa fa-edit" />
        </a>
      )}
      {deletePath && (
        <a
          data-confirm={CONFIRM_ATTRIBUTE_TRANSLATION}
          className="action-item"
          rel="nofollow"
          data-method="delete"
          href={deletePath}
        >
          <i className="fa fa-trash-o" />
        </a>
      )}
    </div>
  );
};

Actions.propTypes = {
  original: PropTypes.shape({
    links: PropTypes.objectOf(PropTypes.string),
  }).isRequired,
};

export default Actions;
