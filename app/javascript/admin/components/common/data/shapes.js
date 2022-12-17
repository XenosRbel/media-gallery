import PropTypes from 'prop-types';

// eslint-disable-next-line import/prefer-default-export
export const optionsShape = PropTypes.shape({
  label: PropTypes.string.isRequired,
  value: PropTypes.oneOfType([PropTypes.string, PropTypes.number]).isRequired,
});

export const UserShape = {
  fullName: PropTypes.string,
};

export const RelationshipShape = {
  data: PropTypes.shape({
    id: PropTypes.string.isRequired,
    type: PropTypes.string.isRequired,
  }).isRequired,
};

export const UserRelationShape = {
  attributes: PropTypes.shape(UserShape).isRequired,
  id: PropTypes.string.isRequired,
  type: PropTypes.string.isRequired,
};

export const remoteEntityAttributesShape = {
  internshipDirectionId: PropTypes.number,
  practiceDirectionId: PropTypes.number,
  recruiterEmail: PropTypes.string,
  recruiterId: PropTypes.number,
  regionId: PropTypes.string,
  requirements: PropTypes.string,
  responsibilities: PropTypes.string,
  status: PropTypes.string,
  title: PropTypes.string,
  youWillBeWithUs: PropTypes.string,
};
