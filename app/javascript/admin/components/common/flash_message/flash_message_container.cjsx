React = require "react"

FlashMessage = require "./presenters/flash_message.cjsx"

class FlashMessageContainer extends React.Component
  constructor: (props) ->
    super(props)
    @state = { isVisible: @props.message.length > 0 }

  componentDidMount: () ->
    @startTimer()

  componentWillUnmount: () ->
    window.clearTimeout(@timer)

  hide: () =>
    @setState({ isVisible: false })

  show: (type = 'info') =>
    @setState({ isVisible: true, type: type }, @startTimer)

  startTimer: () =>
    window.clearTimeout(@timer)
    @timer = setTimeout(@hide, @props.duration)

  render: () ->
    { isVisible, type } = @state

    if isVisible
      <FlashMessage message={@props.message} className={type}/>
    else
      null

module.exports = FlashMessageContainer
