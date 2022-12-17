React = require 'react'

class ErrorMessages extends React.Component
  render: ->
    return (null) unless @props.errors?
    <div className='alert-box radius alert' data-alert=''>
      <a className='close' href='#'>×</a>
      <ul className='no-bullet'>
        {
          @props.errors.map (error, i) =>
            <li key={i}>{ error }</li>
        }
      </ul>
    </div>

module.exports = ErrorMessages
