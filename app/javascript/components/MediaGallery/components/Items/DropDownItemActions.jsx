import React, { useMemo, useCallback, useContext } from 'react';
import PropTypes from 'prop-types';
import { Menu, Dropdown } from 'antd';

import { TRANSLATE_RENAME, TRANSLATE_DELETE, TRANSLATE_CONFIRM_ATTRIBUTE } from './utils';
import { DELETE_HTTP_METHOD, DEFAULT_SYSTEM_GROUP_NAME } from '../../constants/common';
import { submitButton } from '../../../common/utils';
import { MediaGalleryContext } from '../MediaGalleryContext';

const DropDownItemActions = ({ groupAttr, links: { groupPath } }) => {
  const { handleError, handleLoadGalleryItems, handleRenameGroup } = useContext(MediaGalleryContext);

  const handleDeleteGroup = useCallback(async () => {
    const data = await submitButton(DELETE_HTTP_METHOD, groupPath);

    handleLoadGalleryItems();
    handleError(data);
  }, [groupPath, handleError, handleLoadGalleryItems]);

  const menu = useMemo(
    () => (
      <Menu>
        <Menu.Item>
          <a onClick={() => handleRenameGroup({ group: groupAttr, path: groupPath })}>
            <span>{TRANSLATE_RENAME}</span>
          </a>
        </Menu.Item>
        <Menu.Item>
          <a data-confirm={TRANSLATE_CONFIRM_ATTRIBUTE} onClick={handleDeleteGroup}>
            <span>{TRANSLATE_DELETE}</span>
          </a>
        </Menu.Item>
      </Menu>
    ),
    [groupAttr, groupPath, handleDeleteGroup, handleRenameGroup],
  );

  return (
    <>
      <Dropdown
        overlay={menu}
        disabled={groupAttr.name === DEFAULT_SYSTEM_GROUP_NAME}
        onClick={(event) => {
          event.stopPropagation();
        }}
      >
        <a className="antd-dropdown-link antd-btn antd-btn-link antd-btn-icon-only">
          <i className="fa fa-ellipsis-v" />
        </a>
      </Dropdown>
    </>
  );
};

DropDownItemActions.propTypes = {
  groupAttr: PropTypes.shape({
    name: PropTypes.string.isRequired,
    systemName: PropTypes.string.isRequired,
  }),
  links: PropTypes.shape({
    groupPath: PropTypes.string,
  }).isRequired,
};

DropDownItemActions.defaultProps = {
  groupAttr: {
    name: '',
    systemName: '',
  },
};

export default DropDownItemActions;
