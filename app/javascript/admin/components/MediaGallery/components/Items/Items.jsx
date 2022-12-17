import React, { cloneElement } from 'react';
import PropTypes from 'prop-types';
import { Collapse } from 'antd';

import DropDownItemActions from './DropDownItemActions';
import { DEFAULT_ACTIVE_ACCORDION_KEY } from '../../constants/items';

const Items = ({ records, shouldShowGroupActions, galleryComponent }) => (
  <Collapse defaultActiveKey={DEFAULT_ACTIVE_ACCORDION_KEY}>
    {records.map(({ id, attributes: { name, systemName, files }, links }) => (
      <Collapse.Panel
        header={<span className="items-collapse-header">{name}</span>}
        key={id}
        extra={shouldShowGroupActions && <DropDownItemActions links={links} folderAttr={{ name, systemName }} />}
      >
        {cloneElement(galleryComponent, { files, folderId: id, folderSystemName: systemName })}
      </Collapse.Panel>
    ))}
  </Collapse>
);

Items.propTypes = {
  galleryComponent: PropTypes.node.isRequired,
  records: PropTypes.arrayOf(
    PropTypes.shape({
      attributes: PropTypes.shape({
        id: PropTypes.number.isRequired,
        name: PropTypes.string.isRequired,
        systemName: PropTypes.string.isRequired,
      }),
      id: PropTypes.string.isRequired,
    }).isRequired,
  ),
  shouldShowGroupActions: PropTypes.bool,
};

Items.defaultProps = {
  records: [],
  shouldShowGroupActions: true,
};

export default Items;
