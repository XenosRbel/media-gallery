# frozen_string_literal: true

module MediaGallery
  class FileContract < ApplicationContract
    include MediaGallery::ContractConstants

    dependency :folder_repository, default: -> { ::MediaGallery::FolderRepository.new }
    dependency :file_repository, default: -> { ::MediaGallery::FileRepository.new }
    dependency :file_name_sanitizer, default: -> { ::MediaGallery::FileNameSanitizer.new }

    params do
      required(:media_gallery_folder_id).filled(:integer)
      required(:item) do
        type?(ActionDispatch::Http::UploadedFile) ^ type?(Rack::Test::UploadedFile)
      end
      required(:description).value(:string)

      before(:value_coercer) do |result|
        output = result.to_h
        output[:item].blank? ? output.except(:item) : output
      end
    end

    rule(:item) do
      key.failure(:invalid_format) if value.present? && ALLOWED_CONTENT_TYPES.exclude?(value.content_type)

      sanitized_name = file_name_sanitizer.call(value.original_filename)

      if file_repository.exists_in_folder_by_name?(values[:media_gallery_folder_id],
                                                  sanitized_name)
        key.failure(:file_already_exists,
                    { file_name: value.original_filename })
      end

      values.merge!(name: sanitized_name)
    end

    rule(:media_gallery_folder_id) do
      key.failure(:not_exists) if value.blank?
      key.failure(:not_found) unless folder_repository.exists_by_folder_id?(value)
    end
  end
end
