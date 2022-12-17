# frozen_string_literal: true

module Admin
  module MediaGallery
    module File
      class Updater < Base
        dependency :contract, default: -> { ::MediaGallery::UpdaterFileContract.new }

        private

        def validate_params(**kwargs)
          file_params = kwargs.fetch(:file_params)
          file = kwargs.fetch(:file)

          contract.call(file_params.to_h, file: file)
        end

        def process_file(**kwargs)
          file = kwargs.fetch(:file)
          result = kwargs.fetch(:result)

          file&.update(result)
          file
        end
      end
    end
  end
end
