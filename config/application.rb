# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require './lib/core/boolean_method'
require './lib/core/config_reader'
require './lib/core/multiple_cache'
require './lib/core/redis_memory_store'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsReactGallery
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.

    config.eager_load_paths += %W[
      #{config.root}/app/models/concerns
      #{config.root}/app/contracts
      #{config.root}/lib/
    ]

    config.time_zone = 'Minsk'
    config.active_record.schema_format = :ruby
    config.i18n.available_locales = %i[ru en]
    config.i18n.default_locale = :ru

    config.action_controller.include_all_helpers = false
    config.exceptions_app = routes
    config.active_record.dump_schema_after_migration = false

    config.action_dispatch.default_headers['Referrer-Policy'] = 'no-referrer-when-downgrade'

    config.generators.system_tests = nil

    config.middleware.use I18n::JS::Middleware
  end
end
