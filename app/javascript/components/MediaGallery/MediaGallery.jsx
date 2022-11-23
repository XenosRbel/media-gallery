import React, { useState, useEffect } from "react";
import PropTypes from 'prop-types';
import { Link, useNavigate } from "react-router-dom";

const MediaGallery = ({ path, groupsPath, filesPath }) => {
  const navigate = useNavigate();
  const [items, setitems] = useState([]);

  const handleLoadGalleryItems = useCallback(async () => {
    //const galleryItems = await fetchCollection(path);
    console.log(path);
    //setitems(galleryItems);
  }, [path]);

  useEffect(() => {
    handleLoadGalleryItems();
  }, [handleLoadGalleryItems]);

  return (
    <>
      asd

      asdasdasd

      asd
    </>
  );
};

MediaGallery.propTypes = {
  filesPath: PropTypes.string.isRequired,
  groupsPath: PropTypes.string.isRequired,
  path: PropTypes.string.isRequired,
};

export default MediaGallery;
