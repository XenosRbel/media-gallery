# frozen_string_literal: true

module Helpers
  module ControllerHelpers
    def response_json
      JSON.parse(response.body)
    end
  end
end
