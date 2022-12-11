import React, { useRef, useState, useCallback, useEffect, useMemo } from 'react';
import PropTypes from 'prop-types';
import { Modal, message } from 'antd';
import { isEmpty } from 'underscore';

import ActionBar from './components/ActionBar/ActionBar';
import GroupForm from './components/GroupForm';
import AlertBox from './components/AlertBox';
import MediaFolder from './components/MediaFolder/MediaFolder';
import FileUploadForm from './components/FileUploadForm';
import {
  TRANSLATE_CREATE_GROUPFORM,
  TRANSLATE_RENAME,
  TRANSLATE_UPLOAD_FILE_MODAL_TITLE,
  TRANSLATE_FILES_NOT_SELECTED,
} from './constants/mediaGallery';
import { POST_HTTP_METHOD, SUCCESS, FILE_DEFAULT_ATTRIBUTES } from './constants/common';
import { fetchCollection } from '../common/utils';
import Items from './components/Items/Items';
import GroupRenameForm from './components/GroupRenameForm';
import FileDescription from './components/FileDescription';
import { MediaGalleryContextProvider } from './components/MediaGalleryContext';
import { TRANSLATE_ADDITIONAL_INFO_PLACEHOLDER } from './constants/fileDescription';
import { handleDeleteFilesByIds } from './utils/common';

const MediaGallery = ({ path, groupPath, filesPath }) => {
  const [data, setData] = useState({ data: [], meta: {} });
  const { data: items } = data;

  const [errors, setErrors] = useState({ data: {}, method: '', status: 0 });
  const [groupAttributes, setGroupAttributes] = useState({});
  const [selectedFile, setSelectedFile] = useState(FILE_DEFAULT_ATTRIBUTES);
  const fileIds = useRef([]);

  const [isVisibleModalCreateGroup, setIsVisibleModalCreateGroup] = useState(false);
  const [isVisibleModalUploadFile, setIsVisibleModalUploadFile] = useState(false);
  const [isVisibleErrorAlert, setIsVisibleErrorAlert] = useState(false);
  const [isVisibleModalRenameGroup, setIsVisibleModalRenameGroup] = useState(false);
  const [isVisibleFileDescriptionPanel, setIsVisibleFileDescriptionPanel] = useState(false);

  const optionsForGroupSelect = useMemo(
    () => items.map(({ attributes }) => ({ label: attributes.name, value: attributes.id })),
    [items],
  );

  const handleLoadGalleryItems = useCallback(async () => {
    const galleryItems = await fetchCollection(path);

    setData(galleryItems);
  }, [path]);

  const handleCreateGroup = useCallback(() => {
    setIsVisibleModalCreateGroup((prevState) => !prevState);
    handleLoadGalleryItems();
  }, [handleLoadGalleryItems]);

  const handleVisibleAlertBox = useCallback(() => {
    setIsVisibleErrorAlert((prevState) => !prevState);
  }, []);

  const handleError = useCallback(
    (errorsData) => {
      setErrors(errorsData);

      if (!isVisibleErrorAlert) handleVisibleAlertBox();
    },
    [handleVisibleAlertBox, isVisibleErrorAlert],
  );

  const handleRenameGroup = useCallback((groupAttr) => {
    setGroupAttributes(groupAttr);
    setIsVisibleModalRenameGroup((prevState) => !prevState);
  }, []);

  const handleUploadFileModalCancel = useCallback(() => {
    setIsVisibleModalUploadFile((prevState) => !prevState);
  }, []);

  const handleSelectFile = useCallback((file) => {
    setSelectedFile(file);
    setIsVisibleFileDescriptionPanel(true);
  }, []);

  const handleCloseFileDescription = useCallback(() => {
    setSelectedFile({});
    setIsVisibleFileDescriptionPanel(false);
  }, []);

  const handleRemoveSelectedFiles = useCallback(async () => {
    if (isEmpty(fileIds.current)) {
      message.info(TRANSLATE_FILES_NOT_SELECTED);

      return;
    }

    const { status } = await handleDeleteFilesByIds(filesPath, fileIds.current, 'ids');

    if (status === SUCCESS) handleLoadGalleryItems();
  }, [filesPath, handleLoadGalleryItems]);

  useEffect(() => {
    handleLoadGalleryItems();
  }, [handleLoadGalleryItems]);

  return (
    <>
      <ActionBar
        handleGroupCreateClick={handleCreateGroup}
        handleVisibleModalUploadFile={setIsVisibleModalUploadFile}
        handleRemoveSelectedFiles={handleRemoveSelectedFiles}
      />
      <Modal
        title={TRANSLATE_CREATE_GROUPFORM}
        visible={isVisibleModalCreateGroup}
        onCancel={handleCreateGroup}
        footer={null}
        destroyOnClose
      >
        <GroupForm
          createGroupSubmitPath={groupPath}
          handleCreateGroup={handleCreateGroup}
          httpMethod={POST_HTTP_METHOD}
        />
      </Modal>

      <Modal
        title={TRANSLATE_UPLOAD_FILE_MODAL_TITLE}
        visible={isVisibleModalUploadFile}
        onCancel={handleUploadFileModalCancel}
        footer={null}
        destroyOnClose
      >
        <FileUploadForm formUrl={filesPath} selectGroupOptions={optionsForGroupSelect} />
      </Modal>

      {isVisibleErrorAlert && (
        <AlertBox
          alertStatus={errors.status}
          alertData={errors.data}
          afterClose={handleVisibleAlertBox}
          httpMethod={errors.method}
        />
      )}

      <Modal
        title={TRANSLATE_RENAME}
        onCancel={handleRenameGroup}
        visible={isVisibleModalRenameGroup}
        footer={null}
        destroyOnClose
      >
        <GroupRenameForm
          groupAttr={groupAttributes}
          handleCloseForm={setIsVisibleModalRenameGroup}
          handleLoadGalleryItems={handleLoadGalleryItems}
          handleErrorViaAlertBox={handleError}
        />
      </Modal>

      <MediaGalleryContextProvider
        value={{ fileIds, handleError, handleLoadGalleryItems, handleRenameGroup, handleSelectFile }}
      >
        <Items records={items} galleryComponent={<MediaFolder filesPath={filesPath} />} />
      </MediaGalleryContextProvider>

      <Modal
        title={TRANSLATE_ADDITIONAL_INFO_PLACEHOLDER}
        onCancel={handleCloseFileDescription}
        visible={isVisibleFileDescriptionPanel}
        footer={null}
        destroyOnClose
      >
        <FileDescription
          galleryFile={selectedFile}
          filesPath={filesPath}
          handleCloseFileDescription={handleCloseFileDescription}
          handleLoadGalleryItems={handleLoadGalleryItems}
          handleResponseMessage={handleError}
        />
      </Modal>
    </>
  );
};

MediaGallery.propTypes = {
  filesPath: PropTypes.string.isRequired,
  groupPath: PropTypes.string.isRequired,
  path: PropTypes.string.isRequired,
};

export default MediaGallery;
