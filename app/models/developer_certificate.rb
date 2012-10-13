class DeveloperCertificate < ActiveRecord::Base

  before_validation :check_keychain_export

  has_many :provisioning_profiles

  attr_accessible :keychain_export, :keychain_export_passcode

  mount_uploader :keychain_export, P12Uploader

  def to_s
    name
  end

private

  def check_keychain_export
    if keychain_export_changed?
      pkcs12 = OpenSSL::PKCS12.new keychain_export.read, keychain_export_passcode
      ca = pkcs12.certificate.subject.to_a.inject({}) {|c, (key, value)| c[key] = value; c}
      unless ca['UID'] == uid && ca['CN'] == name && ca['O'] == organization && pkcs12.certificate.serial.to_s == serial
        self.errors.add :keychain_export, 'not a match'
      end
    end
  end

end
