# frozen_string_literal: true

module MediaGallery
  class SearcherFileContract < ApplicationContract
    params do
      optional(:file_ids).filled(array[:integer])
      optional(:name).filled(:string)
    end

    rule(:file_ids, :name) do
      key(:params).failure(:empty) if values[:name].blank? && values[:file_ids].blank?
    end
  end
end
