class DeveloperCertificate < ActiveRecord::Base

  has_many :provisioning_profiles

  attr_accessor :keychain_export, :keychain_export_passcode

  def to_s
    name
  end

end
