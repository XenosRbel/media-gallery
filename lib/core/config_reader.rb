# frozen_string_literal: true

module ConfigReader
  class << self
    def config_for(config_name)
      Rails.application.config_for(config_name, env: config_env).deep_symbolize_keys
    end

    private

    def config_env
      ENV["CONFIG_ENV"] || Rails.env
    end
  end
end
