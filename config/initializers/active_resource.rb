# frozen_string_literal: true

Rails.application.config.to_prepare do
  ActiveResource::Base.logger = Rails.logger
end
