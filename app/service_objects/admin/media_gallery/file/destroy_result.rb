# frozen_string_literal: true

module Admin
  module MediaGallery
    module File
      class DestroyResult < File::Result
        attribute? :value, Types::Strict::Bool

        def success?
          value && failure.blank?
        end
      end
    end
  end
end
