# frozen_string_literal: true

module Admin
  module MediaGallery
    module Folder
      class Updater < Folder::Base
        def call(folder_params:, folder:)
          result = contract.call(folder_params.to_h)

          if result.success?
            folder.update(result.to_h)

            build_result(value: folder)
          else
            build_result(failure: folder_errors(result.errors.to_h))
          end
        end
      end
    end
  end
end
