class ProvisioningProfile < ActiveRecord::Base

  attr_accessible :mobileprovision
  
  mount_uploader :mobileprovision, MobileprovisionUploader

end
