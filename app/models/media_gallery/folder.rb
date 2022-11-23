# frozen_string_literal: true

module MediaGallery
  class Folder < ApplicationRecord
    LATIN_LETTERS_PATTERN = /\A^[A-z]+$\z/i.freeze

    has_many :files, foreign_key: :media_gallery_folder_id, class_name: 'MediaGallery::File'

    validates_presence_of :name, :system_name

    validates_format_of :system_name, with: LATIN_LETTERS_PATTERN

    private_constant :LATIN_LETTERS_PATTERN
  end
end
