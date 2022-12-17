# frozen_string_literal: true

module Api
  module V1
    module MediaGallery
      class FilesController < ApplicationController
        before_action :load_resource, only: %i[update show]

        def index
          result = file_searcher.call(params: all_params)

          build_response(result, failure_status: :bad_request)
        end

        def create
          result = file_creator.call(file_params: file_params)

          build_response(result, success_status: :created)
        end

        def update
          result = file_updater.call(file_params: file_params, file: @file)

          build_response(result)
        end

        def destroy
          service_result = file_destroyer.call(params: all_params)

          if service_result.success?
            head :no_content
          else
            render_model_errors(service_result.failure.as_json, :unprocessable_entity)
          end
        end

        def show
          render(json: build_file_serializer(@file).as_json)
        end

        private

        def build_response(service_result, success_status: :ok, failure_status: :unprocessable_entity)
          if service_result.success?
            file_serializer = build_file_serializer(service_result.value)
            render(json: file_serializer.as_json, status: success_status)
          else
            render_model_errors(service_result.failure.as_json, failure_status)
          end
        end

        def file_params
          params.fetch(:file).permit!
        end

        def all_params
          params.permit!.to_unsafe_h
        end

        def render_model_errors(errors, failure_status)
          render(json: { errors: errors }, status: failure_status)
        end

        def serializer_options
          {
            params: {
              camelize_keys: true
            }
          }
        end

        def build_file_serializer(file)
          Admin::MediaGallery::FileSerializer.new(file, serializer_options)
        end

        # :nocov:
        def load_resource
          @file = ::MediaGallery::File.find(params[:id])
        end

        def file_creator
          Admin::MediaGallery::File::Creator.new
        end

        def file_updater
          Admin::MediaGallery::File::Updater.new
        end

        def file_destroyer
          Admin::MediaGallery::File::Destroyer.new
        end

        def file_searcher
          Admin::MediaGallery::File::Searcher.new
        end
        # :nocov:
      end
    end
  end
end
