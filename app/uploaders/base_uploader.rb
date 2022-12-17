# frozen_string_literal: true

class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Piet::CarrierWaveExtension

  TOKEN_LENGTH = 2

  storage :file

  # по умолчанию сжатие без потерь
  process :optimize

  def store_dir
    "storage/#{model.class.base_class.name.underscore}/#{model.id}"
  end

  def filename
    "#{File.basename(original_filename, '.*')}_#{token}.#{file.extension}" if original_filename.present?
  end

  def extension_whitelist
    %w[jpg jpeg png pdf doc docx svg gif]
  end

  protected

  def token
    var = :"@#{mounted_as}_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.hex(TOKEN_LENGTH))
  end
end
