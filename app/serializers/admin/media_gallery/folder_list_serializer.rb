# frozen_string_literal: true

module Admin
  module MediaGallery
    class FolderListSerializer < FolderSerializer
      extend ::SerializeLinkHelper

      set_type :media_gallery_folder

      attribute :files do |object|
        Admin::MediaGallery::FileSerializer.new(object.files).as_json
      end

      define_links :folder
    end
  end
end
