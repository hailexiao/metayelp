class ProfilePhotoUploader < CarrierWave::Uploader::Base
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png bmp)
  end

  def default_url(*)
    ActionController::Base.helpers.asset_path(
      "fallback/" + [version_name, "default.png"].compact.join('_'))
  end
end
