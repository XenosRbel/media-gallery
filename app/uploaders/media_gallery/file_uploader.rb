# frozen_string_literal: true

module MediaGallery
  class FileUploader < CarrierWave::Uploader::Base
    include MediaGallery::Constants
    include CarrierWave::MiniMagick
    include CarrierWave::Video::Thumbnailer
    include Piet::CarrierWaveExtension

    storage :file

    process :store_dimensions

    version :original_image, if: :need_thumb? do
      process thumbnail: [{ size: SIZE_VIDEO_SCREENSHOT_IMAGE }.merge(DEFAULT_THUMBNAIL_PARAMS)]

      def full_filename(file_name)
        jpeg_name(file_name, version_name)
      end
    end

    version :thumbnail_image, if: :image? do
      process resize_to_fill: [SIZE_DEMO_IMAGE, SIZE_DEMO_IMAGE]
    end

    version :video_thumbnail_image, if: :need_thumb? do
      process thumbnail: [{ size: SIZE_DEMO_IMAGE }.merge(DEFAULT_THUMBNAIL_PARAMS)]

      def full_filename(file_name)
        jpeg_name(file_name, version_name)
      end
    end

    after :retrieve_from_cache, :store_dimensions

    def video?
      return unless file

      VIDEO_CONTENT_TYPES.include?(content_type.split("/").last)
    end

    def type
      video? ? :video : :image
    end

    def thumb
      video? ? video_thumbnail_image : thumbnail_image
    end

    def original_image_version
      video? ? original_image : self
    end

    def store_dir
      "storage/files/media_gallery/#{model.folder.system_name}"
    end

    def url
      file_url = super
      file_url.present? ? URI.join(file_url).to_s : file_url
    end

    def filename
      "#{model.name}.#{file.extension}"
    end

    def extension_whitelist
      ALLOWED_VIDEO_EXTENSIONS + ALLOWED_IMAGE_EXTENSIONS
    end

    private

    def store_dimensions(_new_file = nil)
      return unless version_name.nil?

      return unless file && model

      model.width, model.height = file_dimensions
      model.filesize = file.size
    end

    def file_dimensions
      video? ? video_dimensions : image_dimensions
    end

    def video_dimensions
      video_file = FFMPEG::Movie.new(file.file)
      [video_file.width, video_file.height]
    end

    def image_dimensions
      ::MiniMagick::Image.open(file.file).dimensions
    end

    protected

    def jpeg_name(file_name, version_name)
      "#{version_name}_#{file_name}".gsub(::File.extname(file_name), ".#{VIDEO_THUMBNAIL_FORMAT}")
    end

    def need_thumb?(_new_file)
      video?
    end

    def image?(_new_file)
      !video?
    end
  end
end
