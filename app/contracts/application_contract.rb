# frozen_string_literal: true

require 'i18n'
require 'dry/validation'

class ApplicationContract < Dry::Validation::Contract
  include DependencyInitializer

  config.messages.load_paths << Rails.root.join('config', 'locales', 'validation.ru.yml').to_s
  config.messages.top_namespace = :validation
  config.messages.default_locale = :ru
  config.messages.backend = :i18n
end
