import React, { useState, useCallback } from 'react';
import PropTypes from 'prop-types';
import ReactSelect from 'react-select';
import { debounce } from 'underscore';
import { loadRemoteOptionsFor } from '../common/utils';
import { DEFAULT_FETCH_DEBOUNCE_TIME, SELECT_PLACEHOLDER } from '../constants';
import { optionsShape } from '../data/shapes';

const AsyncSelect = ({
  onChange,
  remoteUrl,
  loadRemoteOptions,
  inputLengthToFetch,
  initialValue,
  disabled,
  ...selectProps
}) => {
  const [options, setOptions] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [selectValue, setSelectValue] = useState(initialValue);

  const loadOptions = useCallback(async (inputValue) => {
    setIsLoading(true);

    const newOptions = await loadRemoteOptions(remoteUrl, inputValue);

    setOptions(newOptions);
    setIsLoading(false);
  }, [loadRemoteOptions, remoteUrl]);

  const debouncedLoadOptions = useCallback(debounce(loadOptions, DEFAULT_FETCH_DEBOUNCE_TIME), [loadOptions]);

  const onSelectChange = useCallback((option) => {
    onChange(option);
    setSelectValue(option);
  }, [onChange]);

  const onInputChange = useCallback((inputValue) => {
    if (inputValue.length >= inputLengthToFetch) {
      debouncedLoadOptions(inputValue);
    } else {
      setOptions([]);
    }

    return inputValue;
  }, [inputLengthToFetch, debouncedLoadOptions]);

  return (
    <ReactSelect
      {...selectProps}
      placeholder={SELECT_PLACEHOLDER}
      onInputChange={onInputChange}
      options={options}
      onChange={onSelectChange}
      value={selectValue}
      isLoading={isLoading}
      disabled={disabled}
    />
  );
};

AsyncSelect.propTypes = {
  remoteUrl: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired,
  loadRemoteOptions: PropTypes.func,
  inputLengthToFetch: PropTypes.number,
  initialValue: optionsShape,
  disabled: PropTypes.bool,
};

AsyncSelect.defaultProps = {
  loadRemoteOptions: loadRemoteOptionsFor,
  inputLengthToFetch: 3,
  initialValue: {
    label: '',
    value: '',
  },
  disabled: false,
};

export default AsyncSelect;
