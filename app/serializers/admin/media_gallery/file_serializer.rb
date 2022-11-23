# frozen_string_literal: true

module Admin
  module MediaGallery
    class FileSerializer < BaseSerializer
      set_type :media_gallery_file

      attributes :id,
                 :name,
                 :filesize,
                 :width,
                 :height,
                 :description,
                 :url

      attribute :description do |object|
        object.description.to_s
      end

      attribute :folder_id, &:media_gallery_folder_id

      attribute :original_image do |object|
        object.item.original_image_version.url
      end

      attribute :thumbnail_image do |object|
        object.item.thumb.url
      end

      attribute :folder_name do |object|
        object.folder.name
      end
    end
  end
end
