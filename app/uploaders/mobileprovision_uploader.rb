class MobileprovisionUploader < CarrierWave::Uploader::Base

  storage :file

  process :verify_mobileprovision, :set_model_attributes

  def extension_white_list
    %w(mobileprovision)
  end

private

  def verify_mobileprovision
    message = OpenSSL::PKCS7.new File.read(path)
    message.verify nil, OpenSSL::X509::Store.new, nil, OpenSSL::PKCS7::NOVERIFY
    @plist = Nokogiri::XML message.data
  end

  def plist(key)
    @plist.xpath("//key[.='#{key}']/following-sibling::*[1]").first.try :content
  end

  def set_model_attributes
    model.uuid = plist 'UUID'
    model.name = plist 'Name'
    model.issued_at  = plist 'CreationDate'
    model.expires_at = plist 'ExpirationDate'
    model.application_identifier        = plist 'application-identifier'
    model.team_identifier               = plist 'TeamIdentifier'
    model.application_identifier_prefix = plist 'ApplicationIdentifierPrefix'
    model.provisioned_devices_count = @plist.xpath("//key[.='ProvisionedDevices']/following-sibling::*[1]/string/text()").count
    model.enterprise = @plist.xpath("//key[.='ProvisionsAllDevices']/following-sibling::*[1]").first.try(:name) == 'true'
  end

end
