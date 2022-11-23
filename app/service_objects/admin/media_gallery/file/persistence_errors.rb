# frozen_string_literal: true

require "dry/struct"

module Admin
  module MediaGallery
    module File
      class PersistenceErrors < Dry::Struct
        attribute? :media_gallery_folder_id, Types::Persistence::AttributeErrors
        attribute? :item, Types::Persistence::AttributeErrors
        attribute? :description, Types::Persistence::AttributeErrors
        attribute? :ids, Types::Strict::Hash
      end
    end
  end
end
