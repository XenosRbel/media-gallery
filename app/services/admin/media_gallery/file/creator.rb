# frozen_string_literal: true

module Admin
  module MediaGallery
    module File
      class Creator < Base
        dependency :contract, default: -> { ::MediaGallery::FileContract.new }
        dependency :file_repository, default: -> { ::MediaGallery::FileRepository.new }

        private

        def validate_params(**kwargs)
          file_params = kwargs.fetch(:file_params)

          contract.call(file_params.to_h)
        end

        def process_file(**kwargs)
          result = kwargs.fetch(:result)

          file_repository.create(result)
        end
      end
    end
  end
end
