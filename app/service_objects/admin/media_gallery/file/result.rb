# frozen_string_literal: true

module Admin
  module MediaGallery
    module File
      class Result < BaseResult
        attribute? :value, Types.Instance(::MediaGallery::File)

        attribute? :failure, Types.Instance(Admin::MediaGallery::File::PersistenceErrors)

        def success?
          value.is_a?(::MediaGallery::File) && value.valid? && failure.blank?
        end

        def failure?
          !success?
        end
      end
    end
  end
end
