# frozen_string_literal: true

module Admin
  module MediaGallery
    module File
      class SearchResult < BaseResult
        attribute? :value, Types::Strict::Array.of(Types.Instance(::MediaGallery::File))

        attribute? :failure, Types.Instance(Admin::MediaGallery::File::SearchErrors)

        def success?
          value.is_a?(Array) && failure.blank?
        end

        def failure?
          !success?
        end
      end
    end
  end
end
