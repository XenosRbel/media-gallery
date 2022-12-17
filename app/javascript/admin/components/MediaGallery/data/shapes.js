import PropTypes from 'prop-types';

export const folderOptionShape = PropTypes.shape({
  label: PropTypes.string.isRequired,
  value: PropTypes.number.isRequired,
}).isRequired;

export const fileShape = PropTypes.shape({
  description: PropTypes.string,
  filesize: PropTypes.number,
  folderId: PropTypes.number,
  folderName: PropTypes.string,
  height: PropTypes.number,
  id: PropTypes.number,
  name: PropTypes.string,
  originalImage: PropTypes.string,
  thumbnailImage: PropTypes.string,
  url: PropTypes.string,
  width: PropTypes.number,
});
