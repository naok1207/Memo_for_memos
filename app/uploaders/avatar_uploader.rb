class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  if Rails.env.development? || Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fill: [400, 400]

  def extension_allowlist
    %w[jpg jpeg png]
  end

  def filename
    original_filename
  end
end
