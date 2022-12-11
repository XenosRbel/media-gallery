# frozen_string_literal: true

if Rails.env.test?
  require "ffaker"

  module FFaker
    module Address
      alias old_country country

      def country(given_code = nil)
        old_country(given_code).gsub(/['",]/, "")
      end
    end

    module Name
      alias old_last_name last_name

      def last_name
        old_last_name.gsub(/['",]/, "")
      end
    end
  end
end
