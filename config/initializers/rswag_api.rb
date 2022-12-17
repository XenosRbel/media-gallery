# frozen_string_literal: true

Rswag::Api.configure do |config|
  config.swagger_root = Rails.root.join("public", "api", "docs").to_s
end
