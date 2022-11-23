# frozen_string_literal: true

module Admin
  module MediaGallery
    module Folder
      class Creator < Folder::Base
        dependency :folder_repository, default: -> { ::MediaGallery::FolderRepository.new }

        def call(folder_params:)
          result = contract.call(folder_params.to_h)

          if result.success?
            folder = folder_repository.create(result.to_h)

            build_result(value: folder)
          else
            build_result(failure: folder_errors(result.errors.to_h))
          end
        end
      end
    end
  end
end
