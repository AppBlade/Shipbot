class BuildRule < ActiveRecord::Base

  attr_accessible :native_target_id, :provisioning_profile_id, :build_configuration_id

  belongs_to :native_target
  belongs_to :provisioning_profile
  belongs_to :build_configuration

  has_many :build_tasks

  def to_s
    if provisioning_profile
      "#{build_configuration} configuration with #{provisioning_profile}"
    else
      "#{build_configuration} configuration unsigned"
    end
  end

end
