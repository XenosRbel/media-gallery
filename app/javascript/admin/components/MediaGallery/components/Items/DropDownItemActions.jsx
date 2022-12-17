import React, { useMemo, useCallback, useContext } from 'react';
import PropTypes from 'prop-types';
import { Menu, Dropdown } from 'antd';

import { TRANSLATE_RENAME, TRANSLATE_DELETE, TRANSLATE_CONFIRM_ATTRIBUTE } from './utils';
import { DELETE_HTTP_METHOD, DEFAULT_SYSTEM_GROUP_NAME } from '../../constants/common';
import { submitButton } from '../../../common/utils';
import { MediaGalleryContext } from '../MediaGalleryContext';

const DropDownItemActions = ({ folderAttr, links: { folderPath } }) => {
  const { handleError, handleLoadGalleryItems, handleRenameGroup } = useContext(MediaGalleryContext);

  const handleDeleteGroup = useCallback(async () => {
    const data = await submitButton(DELETE_HTTP_METHOD, folderPath);

    handleLoadGalleryItems();
    handleError(data);
  }, [folderPath, handleError, handleLoadGalleryItems]);

  const items = useMemo(
    () => (
      <menu>
        <li>
          <a onClick={() => handleRenameGroup({ folder: folderAttr, path: folderPath })}>
            <span>{TRANSLATE_RENAME}</span>
          </a>
        </li>
        <li>
          <a data-confirm={TRANSLATE_CONFIRM_ATTRIBUTE} onClick={handleDeleteGroup}>
            <span>{TRANSLATE_DELETE}</span>
          </a>
        </li>
      </menu>
    ),
    [folderAttr, folderPath, handleDeleteGroup, handleRenameGroup],
  );

  return (
    <Dropdown
      menu={items}
      disabled={folderAttr.name === DEFAULT_SYSTEM_GROUP_NAME}
      onClick={(event) => {
        event.stopPropagation();
      }}
    >
      <a className="ant-dropdown-link ant-btn ant-btn-link ant-btn-icon-only">
        <i className="fa fa-ellipsis-v" />
      </a>
  </Dropdown>
  );
};

DropDownItemActions.propTypes = {
  folderAttr: PropTypes.shape({
    name: PropTypes.string.isRequired,
    systemName: PropTypes.string.isRequired,
  }),
  links: PropTypes.shape({
    folderPath: PropTypes.string,
  }).isRequired,
};

DropDownItemActions.defaultProps = {
  folderAttr: {
    name: '',
    systemName: '',
  },
};

export default DropDownItemActions;
