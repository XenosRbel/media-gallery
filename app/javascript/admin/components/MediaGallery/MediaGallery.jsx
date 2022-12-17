import React, { useRef, useState, useCallback, useEffect, useMemo } from 'react';
import PropTypes from 'prop-types';
import { Modal, message } from 'antd';
import { isEmpty } from 'underscore';

import ActionBar from './components/ActionBar/ActionBar';
import FolderForm from './components/FolderForm';
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
import FolderRenameForm from './components/FolderRenameForm';
import FileDescription from './components/FileDescription';
import { MediaGalleryContextProvider } from './components/MediaGalleryContext';
import { TRANSLATE_ADDITIONAL_INFO_PLACEHOLDER } from './constants/fileDescription';
import { handleDeleteFilesByIds } from './utils/common';

const MediaGallery = ({ path, foldersPath, filesPath }) => {
  const [data, setData] = useState({ data: [], meta: {} });
  const { data: items } = data;

  const [errors, setErrors] = useState({ data: {}, method: '', status: 0 });
  const [folderAttributes, setFolderAttributes] = useState({});
  const [selectedFile, setSelectedFile] = useState(null);
  const fileIds = useRef([]);

  const [isVisibleModalCreateFolder, setIsVisibleModalCreateFolder] = useState(false);
  const [isVisibleModalUploadFile, setIsVisibleModalUploadFile] = useState(false);
  const [isVisibleErrorAlert, setIsVisibleErrorAlert] = useState(false);
  const [isVisibleModalRenameFolder, setIsVisibleModalRenameFolder] = useState(false);
  const [isVisibleFileDescriptionPanel, setIsVisibleFileDescriptionPanel] = useState(false);

  const optionsForFolderSelect = useMemo(
    () => items?.map(({ attributes }) => ({ label: attributes.name, value: attributes.id })),
    [items],
  );

  const handleLoadGalleryItems = useCallback(async () => {
    const galleryItems = await fetchCollection(path);

    setData(galleryItems);
  }, [path]);

  const handleCreateFolder = useCallback(() => {
    setIsVisibleModalCreateFolder((prevState) => !prevState);
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

  const handleRenameFolder = useCallback((folderAttr) => {
    setFolderAttributes(folderAttr);
    setIsVisibleModalRenameFolder((prevState) => !prevState);
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
        handleFolderCreateClick={handleCreateFolder}
        handleVisibleModalUploadFile={setIsVisibleModalUploadFile}
        handleRemoveSelectedFiles={handleRemoveSelectedFiles}
      />
      <Modal
        title={TRANSLATE_CREATE_GROUPFORM}
        open={isVisibleModalCreateFolder}
        onCancel={handleCreateFolder}
        footer={null}
        destroyOnClose
      >
        <FolderForm
          createFolderSubmitPath={foldersPath}
          handleCreateFolder={handleCreateFolder}
          httpMethod={POST_HTTP_METHOD}
        />
      </Modal>

      <Modal
        title={TRANSLATE_UPLOAD_FILE_MODAL_TITLE}
        open={isVisibleModalUploadFile}
        onCancel={handleUploadFileModalCancel}
        footer={null}
        destroyOnClose
      >
        <FileUploadForm formUrl={filesPath} selectFolderOptions={optionsForFolderSelect} />
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
        onCancel={handleRenameFolder}
        open={isVisibleModalRenameFolder}
        footer={null}
        destroyOnClose
      >
        <FolderRenameForm
          folderAttr={folderAttributes}
          handleCloseForm={setIsVisibleModalRenameFolder}
          handleLoadGalleryItems={handleLoadGalleryItems}
          handleErrorViaAlertBox={handleError}
        />
      </Modal>

      <MediaGalleryContextProvider
        value={{ fileIds, handleError, handleLoadGalleryItems, handleRenameFolder, handleSelectFile }}
      >
        <Items records={items} galleryComponent={<MediaFolder filesPath={filesPath} />} />
      </MediaGalleryContextProvider>

      <Modal
        title={TRANSLATE_ADDITIONAL_INFO_PLACEHOLDER}
        onCancel={handleCloseFileDescription}
        open={isVisibleFileDescriptionPanel}
        footer={null}
        destroyOnClose
      >
        {selectedFile && (
          <FileDescription
            galleryFile={selectedFile}
            filesPath={filesPath}
            handleCloseFileDescription={handleCloseFileDescription}
            handleLoadGalleryItems={handleLoadGalleryItems}
            handleResponseMessage={handleError}
          />
        )}
      </Modal>
    </>
  );
};

MediaGallery.propTypes = {
  filesPath: PropTypes.string.isRequired,
  foldersPath: PropTypes.string.isRequired,
  path: PropTypes.string.isRequired,
};

export default MediaGallery;
