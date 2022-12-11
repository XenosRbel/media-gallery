import PropTypes from 'prop-types';

export const groupOptionShape = PropTypes.shape({
  label: PropTypes.string.isRequired,
  value: PropTypes.number.isRequired,
}).isRequired;

export const fileShape = PropTypes.shape({
  description: PropTypes.string,
  filesize: PropTypes.number,
  groupId: PropTypes.number,
  groupName: PropTypes.string,
  height: PropTypes.number,
  id: PropTypes.number,
  name: PropTypes.string,
  originalImage: PropTypes.string,
  thumbnailImage: PropTypes.string,
  url: PropTypes.string,
  width: PropTypes.number,
});
