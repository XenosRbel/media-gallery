import React from 'react';
import { shallow } from 'enzyme';

import Items from '../Items';

describe('Component: Items', () => {
  const galleryComponent = <div> </div>;

  const wrapper = shallow(<Items galleryComponent={galleryComponent} />);

  it('should render correctly', () => {
    expect(wrapper).toMatchSnapshot();
  });
});
