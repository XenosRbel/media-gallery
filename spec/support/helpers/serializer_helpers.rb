# frozen_string_literal: true

module Helpers
  module SerializerHelpers
    def self.serialize_users(users)
      users.map { |user| { label: user.full_name, value: user.id, is_hr: user.hr?, email: user.email } }
    end
  end
end
