# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ::ApplicationController
      respond_to :json

      protect_from_forgery with: :exception

      skip_before_action :verify_authenticity_token

      layout nil

      private

      def redirect_to_action_if_valid(model, action = :index)
        if model.valid?
          redirect_to action: action
        else
          respond_with model, status: :unprocessable_entity
        end
      end

      def redirect_back_or_root(**args)
        redirect_back(fallback_location: root_path, **args)
      end
    end
  end
end
