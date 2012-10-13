class BuildRule < ActiveRecord::Base

  attr_accessible :native_target_id, :provisioning_profile_id

  belongs_to :native_target
  belongs_to :provisioning_profile

end
