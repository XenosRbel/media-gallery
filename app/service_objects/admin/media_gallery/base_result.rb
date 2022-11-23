# frozen_string_literal: true

module Admin
  module MediaGallery
    class BaseResult < Dry::Struct
      def success?
        raise NotImplementedError, "Method \"#{__method__}\" is not implemented."
      end

      def failure?
        raise NotImplementedError, "Method \"#{__method__}\" is not implemented."
      end
    end
  end
end
