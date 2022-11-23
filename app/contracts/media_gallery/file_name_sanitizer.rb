# frozen_string_literal: true

module MediaGallery
  class FileNameSanitizer < ApplicationService
    dependency :transliteration_service, default: -> { Russian }

    def call(original_filename)
      return original_filename if original_filename.blank?

      file_name = original_filename.split('.').first.upcase

      transliteration_service.translit(file_name)
    end
  end
end
