# frozen_string_literal: true

Rswag::Api.configure do |config|
  config.swagger_root = Rails.root.join("public", "api", "docs").to_s

  # Inject a lamda function to alter the returned Swagger prior to serialization
  # The function will have access to the rack env for the current request
  # For example, you could leverage this to dynamically assign the "host" property
  #
  # config.swagger_filter = lambda { |swagger, env| swagger['host'] = env['HTTP_HOST'] }
end
