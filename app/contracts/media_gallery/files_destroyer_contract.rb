# frozen_string_literal: true

module MediaGallery
  class FilesDestroyerContract < ApplicationContract
    params do
      optional(:ids).filled(array[:integer])
      optional(:id).filled(:integer)
    end

    rule(:ids, :id) do
      key(:params).failure(:empty) if values[:id].blank? && values[:ids].blank?
    end
  end
end
