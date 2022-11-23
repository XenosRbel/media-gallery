# frozen_string_literal: true

module MediaGallery
  module Specifications
    module File
      class SearchSpecification
        def build_query(value, size:)
          {
            query: build_query_conditions(value),
            size: size
          }
        end

        private

        def build_query_conditions(query)
          {
            match_phrase_prefix: {
              name: {
                query: query
              }
            }
          }
        end
      end
    end
  end
end
