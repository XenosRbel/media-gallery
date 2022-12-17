# frozen_string_literal: true

require_relative "boot"

require "rails/all"
require "csv"

require "./lib/core/boolean_method"
require "./lib/core/config_reader"
require "./lib/core/multiple_cache"
require "./lib/core/redis_memory_store"

Bundler.require(*Rails.groups)

module MediaGalleryAdmin
  class Application < Rails::Application
    config.app_generators.scaffold_controller :responders_controller
    config.x = ConfigReader.config_for(:config)
    cors_settings = config.x.fetch(:cors_settings)
    if cors_settings.present?
      config.middleware.insert_before 0, Rack::Cors do
        allow do
          origins(*cors_settings.fetch(:domains))
          resource "*", headers: :any, methods: cors_settings.fetch(:methods)
        end
      end
    end
    config.middleware.use Rack::Attack
    config.time_zone = "Minsk"
    config.active_record.schema_format = :ruby
    config.i18n.available_locales = %i[ru en]
    config.i18n.default_locale = :ru
    config.eager_load_paths += %W[
      #{config.root}/app/models/admin/concerns
      #{config.root}/app/contracts
      #{config.root}/lib/
    ]
    config.action_controller.include_all_helpers = false
    config.exceptions_app = routes
    config.cache_store = MultipleCache.new
    config.active_record.dump_schema_after_migration = false
    config.action_dispatch.default_headers["Referrer-Policy"] = "no-referrer-when-downgrade"
  end
end
