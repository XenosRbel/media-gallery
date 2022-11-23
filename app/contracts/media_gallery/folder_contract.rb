# frozen_string_literal: true

module MediaGallery
  class FolderContract < ApplicationContract
    LATIN_LETTERS_PATTERN = /\A[A-z]+\z/i.freeze

    private_constant :LATIN_LETTERS_PATTERN

    params do
      required(:system_name).filled(:string, format?: LATIN_LETTERS_PATTERN)
      required(:name).filled(:string)
    end
  end
end
