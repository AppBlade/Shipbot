class P12Uploader < CarrierWave::Uploader::Base

  storage :file

  def extension_white_list
    %w(p12)
  end

  def store_dir
    "uploads/certificates/#{model.id}"
  end

end
