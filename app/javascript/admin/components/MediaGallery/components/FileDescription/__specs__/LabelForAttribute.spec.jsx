import React from 'react';
import { shallow } from 'enzyme';

import LabelForAttribute from '../LabelForAttribute';

describe('Component: LabelForAttribute', () => {
  const wrapper = shallow(<LabelForAttribute />);

  it('renders correctly', () => {
    expect(wrapper).toMatchSnapshot();
  });
});
