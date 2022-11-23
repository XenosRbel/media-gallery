# frozen_string_literal: true

module MediaGallery
  module ContractConstants
    ALLOWED_CONTENT_TYPES = %w[
      image/jpeg
      image/x-citrix-jpeg
      image/pjpeg
      image/png
      image/x-citrix-png
      image/x-png
      image/gif
      video/mpeg
      video/mp4
      video/quicktime
      video/webm
      video/x-ms-wmv
      video/x-flv
      video/x-msvideo
      video/3gpp
      video/3gpp2
    ].freeze

    private_constant :ALLOWED_CONTENT_TYPES
  end
end
