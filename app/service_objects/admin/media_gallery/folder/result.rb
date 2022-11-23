# frozen_string_literal: true

module Admin
  module MediaGallery
    module Folder
      class Result < BaseResult
        attribute? :value, Types.Instance(::MediaGallery::Folder)

        attribute? :failure, Types.Instance(Admin::MediaGallery::Folder::PersistenceErrors)

        def success?
          value.is_a?(::MediaGallery::Folder) && value.valid? && failure.blank?
        end

        def failure?
          !success?
        end
      end
    end
  end
end
