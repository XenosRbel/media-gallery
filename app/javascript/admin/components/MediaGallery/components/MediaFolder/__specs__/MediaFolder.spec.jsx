import React, { useContext } from 'react';
import { shallow } from 'enzyme';

import MediaFolder from '../MediaFolder';

useContext.mockReturnValue({
  handleError: jest.fn(),
  handleLoadGalleryItems: jest.fn(),
});

describe('Component: MediaFolder', () => {
  const filesPath = 'http://test.com';

  const wrapper = shallow(<MediaFolder filesPath={filesPath} />);

  it('should render correctly', () => {
    expect(wrapper).toMatchSnapshot();
  });
});
