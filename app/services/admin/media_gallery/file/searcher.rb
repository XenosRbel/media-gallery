# frozen_string_literal: true

module Admin
  module MediaGallery
    module File
      class Searcher < Base
        dependency :contract, default: -> { ::MediaGallery::SearcherFileContract.new }
        dependency :file_query, default: -> { ::MediaGallery::FileQuery.new }

        private

        def validate_params(**kwargs)
          params = kwargs.fetch(:params)

          contract.call(params)
        end

        def process_file(**kwargs)
          result = kwargs.fetch(:result)

          file_query.call(result).to_a
        end

        def build_result(**attributes)
          Admin::MediaGallery::File::SearchResult.new(**attributes)
        end

        def file_errors(errors)
          Admin::MediaGallery::File::SearchErrors.new(errors)
        end
      end
    end
  end
end
