# frozen_string_literal: true

module Admin
  module MediaGallery
    module File
      class Destroyer < File::Base
        dependency :contract, default: -> { ::MediaGallery::FilesDestroyerContract.new }
        dependency :file_repository, default: -> { ::MediaGallery::FileRepository.new }

        private

        def validate_params(**kwargs)
          params = kwargs.fetch(:params)

          contract.call(params)
        end

        def process_file(**kwargs)
          result = kwargs.fetch(:result)
          id = result[:id]
          ids = result.fetch(:ids, []).then { |file_ids| id.present? ? file_ids + [id] : file_ids }

          file_repository.destroy_all_by_ids(ids.uniq)
          true
        end

        def build_result(**attributes)
          Admin::MediaGallery::File::DestroyResult.new(**attributes)
        end
      end
    end
  end
end
