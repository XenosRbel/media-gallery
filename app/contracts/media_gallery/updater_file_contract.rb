# frozen_string_literal: true

module MediaGallery
  class UpdaterFileContract < ApplicationContract
    include MediaGallery::ContractConstants

    params do
      optional(:item) do
        type?(ActionDispatch::Http::UploadedFile) ^ type?(Rack::Test::UploadedFile)
      end
      required(:description).value(:string)

      before(:value_coercer) do |result|
        output = result.to_h
        output[:item].blank? ? output.except(:item) : output
      end
    end

    rule(:item) do |context:|
      next unless value.present?

      key.failure(:invalid_format) if ALLOWED_CONTENT_TYPES.exclude?(value.content_type)
      key.failure(:format_mismatch) if context[:file].item.content_type != value.content_type
    end
  end
end
