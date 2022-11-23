# frozen_string_literal: true

module Admin
  module MediaGallery
    class FolderSerializer < BaseSerializer
      set_type :media_gallery_folder

      attributes :id,
                 :name,
                 :system_name

      attribute :media_gallery_file_ids, &:file_ids
    end
  end
end
