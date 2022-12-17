# frozen_string_literal: true

require "dry-types"

module Types
  include Dry.Types()
  module Persistence
    AttributeErrors = Types::Strict::Array.of(Types::Strict::String)
  end

  module Validation
    AttributeErrors = Types::Strict::Array.of(Types::Strict::String)
  end
end
