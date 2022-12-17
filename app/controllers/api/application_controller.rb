require "application_responder"

# frozen_string_literal: true

module Api
  class ApplicationController < ::ActionController::Base
    self.responder = ApplicationResponder

    layout nil
    respond_to :json
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActionController::ParameterMissing, with: :bad_request

    private

    def record_not_found
      head :not_found
    end

    def record_invalid
      head :unprocessable_entity
    end

    def bad_request
      head :bad_request
    end
  end
end
