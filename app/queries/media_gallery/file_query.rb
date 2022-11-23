# frozen_string_literal: true

module MediaGallery
  class FileQuery < ::BaseQuery
    dependency :file_repository, default: -> { ::MediaGallery::FileRepository.new }

    def call(params)
      ids = params.fetch(:file_ids, []).to_set | find_ids_by_name(params).to_set

      file_repository.find_by_ids(ids.to_a)
    end

    private

    def find_ids_by_name(params)
      return [] if params[:name].blank?

      query_response = file_repository.find_all_by_name(params[:name])
      build_object_ids(query_response.results)
    end

    def build_object_ids(results)
      return [] if results.blank?

      results.map { |result| result.id.to_i }
    end
  end
end
