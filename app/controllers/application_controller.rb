# frozen_string_literal: true

require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  respond_to :html
  before_action :set_locale, :sort_params

  private

  def sort_params
    @sorted_params = params.to_unsafe_hash.sort.to_h
  end

  def set_locale
    I18n.locale = params.fetch(:locale, I18n.default_locale)
  end

  def default_url_options(_options = {})
    { locale: (I18n.locale == I18n.default_locale ? nil : I18n.locale) }
  end

  def allow_iframe
    response.headers.delete "X-Frame-Options"
  end

  def api_request?
    request.format.json? || request.format.xml?
  end
end
