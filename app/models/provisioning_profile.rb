class ProvisioningProfile < ActiveRecord::Base

  attr_accessible :mobileprovision
  
  mount_uploader :mobileprovision, MobileprovisionUploader

  validates :uuid, :uniqueness => true

  def unqualified_application_identifier
    application_identifier.gsub "#{application_identifier_prefix.strip}.", ''
  end

end
