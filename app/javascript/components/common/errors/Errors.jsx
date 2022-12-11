import React, { useContext } from 'react';
import PropTypes from 'prop-types';
import { ErrorsContext } from './ErrorsContext';

const Errors = ({ attribute }) => {
  const { [attribute]: messages } = useContext(ErrorsContext);

  return messages ? (
    <div className="error">
      {
        messages.map((message, index) => (
          <p key={`error-${index}`}>{ message }</p>
        ))
      }
    </div>
  ) : null;
};

Errors.propTypes = {
  attribute: PropTypes.string.isRequired,
};

export default Errors;
