# frozen_string_literal: true

CarrierWave.configure do |config|
  config.enable_processing = !Rails.env.test?
end

BaseUploader.root = proc { "#{Rails.root}/spec/support/uploads/" } if Rails.env.test?

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
