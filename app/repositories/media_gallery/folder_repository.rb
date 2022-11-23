# frozen_string_literal: true

module MediaGallery
  class FolderRepository < BaseRepository
    dependency :relation, default: -> { ::MediaGallery::Folder.all }

    def create(attributes)
      relation.create!(attributes)
    end

    def find_all
      relation
    end

    def exists_by_folder_id?(folder_id)
      relation.exists?(id: folder_id)
    end
  end
end
