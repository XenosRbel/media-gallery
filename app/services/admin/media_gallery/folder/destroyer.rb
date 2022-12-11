# frozen_string_literal: true

module Admin
  module MediaGallery
    module Folder
      class Destroyer < Folder::Base
        def call(folder:)
          if folder&.files&.empty? && folder.destroy
            build_result(value: folder)
          else
            folder.errors.add(:files, :has_dependent_records)

            build_result(failure: folder_errors(folder.errors.to_h))
          end
        end
      end
    end
  end
end
