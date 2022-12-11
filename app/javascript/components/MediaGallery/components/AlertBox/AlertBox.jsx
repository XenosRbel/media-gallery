import React from 'react';
import PropTypes from 'prop-types';
import { Alert } from 'antd';

import { TRANSLATION_SCOPE } from '../../constants/alertBox';
import { ERROR } from '../../constants/common';
import { getErrorStatusByErrorCode } from '../../utils/common';

const AlertBox = ({ alertStatus, alertData, afterClose, httpMethod }) => {
  const alertType = getErrorStatusByErrorCode(alertStatus);

  const errosMessage = () => {
    if (alertData.constructor === String) {
      return alertData;
    }

    return Object.values(alertData.errors).join(',');
  };

  const successMessage = () => "I18n.t(`${httpMethod}.success`, { ...TRANSLATION_SCOPE })";
  const description = () => (ERROR === alertType ? errosMessage() : successMessage());

  return (
    <div className="alert-box-mb">
      <Alert
        message={"I18n.t(`tips.${alertType}`, TRANSLATION_SCOPE)"}
        type={alertType}
        description={<p>{description()}</p>}
        showIcon
        closable
        afterClose={afterClose}
      />
    </div>
  );
};

AlertBox.propTypes = {
  afterClose: PropTypes.func.isRequired,
  alertData: PropTypes.oneOfType([PropTypes.string, PropTypes.object]).isRequired,
  alertStatus: PropTypes.oneOfType([PropTypes.string, PropTypes.number]).isRequired,
  httpMethod: PropTypes.string.isRequired,
};

export default AlertBox;
