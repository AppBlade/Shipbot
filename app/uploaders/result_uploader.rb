class ResultUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "uploads/results/#{model.id}"
  end

end

