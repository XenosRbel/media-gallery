# frozen_string_literal: true

Rails.application.configure do
  config.require_master_key = Boolean(ENV.fetch("REQUIRE_MASTER_KEY", true))
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass
  config.assets.compile = false
  config.assets.digest = true
  config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for NGINX
  config.log_level = ENV.fetch("LOG_LEVEL", "info").to_sym
  config.log_tags = [:request_id] unless Boolean(ENV["LOGRAGE_FORMATTERS_JSON_ENABLED"])
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new unless Boolean(ENV["LOGRAGE_FORMATTERS_JSON_ENABLED"])

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  config.colorize_logging = ENV["RAILS_LOG_COLORIZE"].present?

  config.react.variant = :production
end
