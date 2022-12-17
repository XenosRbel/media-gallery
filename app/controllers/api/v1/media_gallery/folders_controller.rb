# frozen_string_literal: true

module Api
  module V1
    module MediaGallery
      class FoldersController < ApplicationController
        before_action :load_resource, only: %i[update destroy]

        def create
          result = folder_creator.call(folder_params: folder_params)

          build_response(result, :created)
        end

        def update
          result = folder_updater.call(folder_params: folder_params, folder: @folder)

          build_response(result, :ok)
        end

        def destroy
          result = folder_destroyer.call(folder: @folder)

          build_response(result, :ok, failure_code: :bad_request)
        end

        private

        def build_response(service_result, status, failure_code: :unprocessable_entity)
          if service_result.success?
            folder_serializer = build_folder_serializer(service_result.value)
            render(json: folder_serializer.as_json, status: status)
          else
            render_model_errors(service_result.failure.as_json, failure_code)
          end
        end

        def folder_params
          params.fetch(:folder).permit!
        end

        def render_model_errors(errors, failure_code)
          render(json: { errors: errors }, status: failure_code)
        end

        def build_folder_serializer(folder)
          Admin::MediaGallery::FolderSerializer.new(folder)
        end

        # :nocov:
        def load_resource
          @folder = ::MediaGallery::Folder.find(params[:id])
        end

        def folder_updater
          Admin::MediaGallery::Folder::Updater.new
        end

        def folder_creator
          Admin::MediaGallery::Folder::Creator.new
        end

        def folder_destroyer
          Admin::MediaGallery::Folder::Destroyer.new
        end
        # :nocov:
      end
    end
  end
end
