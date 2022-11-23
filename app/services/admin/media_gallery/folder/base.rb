# frozen_string_literal: true

module Admin
  module MediaGallery
    module Folder
      class Base < ApplicationService
        dependency :contract, default: -> { ::MediaGallery::FolderContract.new }

        def call
          raise NotImplementedError, "Method \"#{__method__}\" is not implemented."
        end

        private

        def build_result(**attributes)
          Admin::MediaGallery::Folder::Result.new(**attributes)
        end

        def folder_errors(errors)
          Admin::MediaGallery::Folder::PersistenceErrors.new(errors)
        end
      end
    end
  end
end
