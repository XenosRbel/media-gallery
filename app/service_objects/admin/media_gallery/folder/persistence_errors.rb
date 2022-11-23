# frozen_string_literal: true

require "dry/struct"

module Admin
  module MediaGallery
    module Folder
      class PersistenceErrors < Dry::Struct
        attribute? :id, Types::Strict::Integer
        attribute? :name, Types::Persistence::AttributeErrors
        attribute? :system_name, Types::Persistence::AttributeErrors
        attribute? :files, Types::Strict::String
      end
    end
  end
end
