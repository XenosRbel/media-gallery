# frozen_string_literal: true

require "dry/struct"

module Admin
  module MediaGallery
    module File
      class SearchErrors < Dry::Struct
        attribute? :file_ids, Types::Strict::Hash
        attribute? :name, Types::Persistence::AttributeErrors
        attribute? :params, Types::Persistence::AttributeErrors
      end
    end
  end
end
