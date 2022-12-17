# frozen_string_literal: true

module Helpers
  module QueryHelpers
    def self.build_formatted_authorization_conditions(relation, current_ability, current_action)
      authorization_conditions = build_authorization_conditions(relation, current_ability, current_action)
      authorization_conditions.each_with_object({}) do |(key, value), result|
        result["recruiterIds"] = [value] if key == :recruiterId
      end
    end

    def self.build_authorization_conditions(relation, current_ability, current_action)
      relation.accessible_by(current_ability, current_action)
    end
  end
end
