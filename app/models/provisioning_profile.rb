class ProvisioningProfile < ActiveRecord::Base

  attr_accessible :mobileprovision
  
  mount_uploader :mobileprovision, MobileprovisionUploader

  belongs_to :developer_certificate

  validates :uuid, :uniqueness => true

  def unqualified_application_identifier
    application_identifier.gsub "#{application_identifier_prefix.strip}.", ''
  end

  def to_s
    name
  end

end
