import React from 'react';
import { shallow } from 'enzyme';

import FileDescription from '../FileDescription';

describe('Component: FileDescription', () => {
  const file = {
    description: '',
    filesize: 1024,
    folderId: 1,
    height: 1,
    id: 1,
    name: '',
    thumbnailImage: '',
    url: '',
    width: 1,
  };

  const filesPath = 'http://test.com';
  const handleCloseFileDescription = jest.fn();
  const handleLoadGalleryItems = jest.fn();
  const handleResponseMessage = jest.fn();

  const wrapper = shallow(
    <FileDescription
      galleryFile={file}
      filesPath={filesPath}
      handleCloseFileDescription={handleCloseFileDescription}
      handleLoadGalleryItems={handleLoadGalleryItems}
      handleResponseMessage={handleResponseMessage}
    />,
  );

  it('renders correctly', () => {
    expect(wrapper).toMatchSnapshot();
  });
});
