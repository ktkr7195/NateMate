class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_fill: [500, 500, 'Center']

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  process convert: 'jpg'

  version :thumb do
    process resize_to_fill: [300, 300, 'Center']
  end

  def extension_whitelist
    %w[jpg jpeg png]
  end
end
