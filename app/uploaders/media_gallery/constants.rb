# frozen_string_literal: true

module MediaGallery
  module Constants
    VIDEO_THUMBNAIL_FORMAT = "jpg"
    SIZE_DEMO_IMAGE = 128
    SIZE_VIDEO_SCREENSHOT_IMAGE = 1920

    VIDEO_CONTENT_TYPES = %w[
      mpeg
      mp4
      quicktime
      webm
      x-ms-wmv
      x-flv
      x-msvideo
      3gpp
      3gpp2
    ].freeze

    ALLOWED_VIDEO_EXTENSIONS = %w[
      mpeg
      mp4
      webm
      wmv
      flv
      avi
      3gpp
      3gp
      3gpp2
      3g2
    ].freeze

    ALLOWED_IMAGE_EXTENSIONS = %w[
      jpg
      jpeg
      png
      svg
      gif
      tiff
      wbmp
      webp
      ico
    ].freeze

    DEFAULT_THUMBNAIL_PARAMS = {
      format: VIDEO_THUMBNAIL_FORMAT,
      seek: -1
    }.freeze

    private_constant :VIDEO_CONTENT_TYPES,
                     :ALLOWED_IMAGE_EXTENSIONS,
                     :ALLOWED_VIDEO_EXTENSIONS,
                     :SIZE_DEMO_IMAGE,
                     :SIZE_VIDEO_SCREENSHOT_IMAGE
  end
end
