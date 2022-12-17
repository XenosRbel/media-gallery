React = require "react"

FlashMessage = ({ message, className}) =>
  <div className="alert-box radius #{className}" data-alert="">
    { message }
    <a className="close" href="#">&times</a>
  </div>

module.exports = FlashMessage
