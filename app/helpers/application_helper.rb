# frozen_string_literal: true

module ApplicationHelper
  include Rails.application.routes.url_helpers
  include Api::Engine.routes.url_helpers
end
