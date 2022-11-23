# frozen_string_literal: true

module Admin
  module MediaGallery
    module File
      class Base < ApplicationService
        def call(**kwargs)
          result = validate_params(kwargs)

          if result.success?
            file = process_file(**kwargs, result: result.to_h)

            build_result(value: file)
          else
            build_result(failure: file_errors(result.errors.to_h))
          end
        end

        private

        def build_result(**attributes)
          Admin::MediaGallery::File::Result.new(**attributes)
        end

        def file_errors(errors)
          Admin::MediaGallery::File::PersistenceErrors.new(errors)
        end

        def validate_params(**_kwargs)
          raise NotImplementedError, "Method \"#{__method__}\" is not implemented."
        end

        def process_file(**_kwargs)
          raise NotImplementedError, "Method \"#{__method__}\" is not implemented."
        end
      end
    end
  end
end
