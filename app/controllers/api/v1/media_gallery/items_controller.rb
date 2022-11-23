# frozen_string_literal: true

module Api
  module V1
    module MediaGallery
      class ItemsController < ApplicationController
        # skip_load_resource only: :index

        def index
          respond_to do |format|
            format.html
            format.json { render(json: folder_serializer.to_hash) }
          end
        end

        private

        def serializer_options
          {
            is_collection: true,
            params: {
              camelize_keys: true,
              folder_path_helper: method(:media_gallery_folder_path)
            }
          }
        end

        def folder_serializer
          Admin::MediaGallery::FolderListSerializer.new(folder_repository.find_all, serializer_options)
        end

        def folder_repository
          ::MediaGallery::FolderRepository.new
        end
      end
    end
  end
end
