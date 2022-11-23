# frozen_string_literal: true

module MediaGallery
  class FileRepository < BaseRepository
    dependency :relation, default: -> { ::MediaGallery::File.all }
    dependency :search_specification, default: -> { MediaGallery::Specifications::File::SearchSpecification.new }

    def create(attributes)
      relation.create!(attributes)
    end

    def exists_in_folder_by_name?(folder_id, name)
      relation.exists?(name: name, media_gallery_folder_id: folder_id)
    end

    def find_all_by_name(value, size: DEFAULT_QUERY_SIZE)
      query = search_specification.build_query(value.downcase, size: size)
      relation.search(query)
    end

    def find_by_ids(ids)
      relation.where(id: ids)
    end

    def destroy_all_by_ids(ids)
      relation.where(id: ids).in_batches(of: BATCH_SIZE).destroy_all
    end

    DEFAULT_QUERY_SIZE = 10
    BATCH_SIZE = 100

    private_constant :BATCH_SIZE, :DEFAULT_QUERY_SIZE
  end
end
