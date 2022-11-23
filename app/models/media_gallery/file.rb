# frozen_string_literal: true

module MediaGallery
  class File < ApplicationRecord
    self.table_name = 'media_gallery_files'

    # include SearchableModel

    belongs_to :folder, foreign_key: :media_gallery_folder_id, class_name: 'MediaGallery::Folder'

    validates_presence_of :name, :item

    validates_numericality_of :filesize, :width, :height, only_integer: true

    # mount_uploader :item, MediaGallery::FileUploader

    delegate :video?, :url, to: :item

    # searched_by :name
  end
end
