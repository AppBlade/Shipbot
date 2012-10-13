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
    model.team_identifier               = plist('TeamIdentifier').strip
    model.application_identifier_prefix = plist('ApplicationIdentifierPrefix').strip
    
    model.provisioned_devices_count = @plist.xpath("//key[.='ProvisionedDevices']/following-sibling::*[1]/string/text()").count
    model.enterprise = @plist.xpath("//key[.='ProvisionsAllDevices']/following-sibling::*[1]").first.try(:name) == 'true'

    normalized_der = "-----BEGIN CERTIFICATE-----\n#{@plist.xpath("//key[.='DeveloperCertificates']/following-sibling::*[1]/data/text()").first.content.strip}\n-----END CERTIFICATE-----\n"
    certificate = OpenSSL::X509::Certificate.new normalized_der
    attributes = certificate.subject.to_a.inject({}) {|c, (key, value)| c[key] = value; c}
    model.developer_certificate = DeveloperCertificate.where(:uid => attributes['UID']).first || DeveloperCertificate.new
    
    if model.developer_certificate.new_record?
      model.developer_certificate.der = normalized_der
      model.developer_certificate.uid = attributes['UID']
      model.developer_certificate.serial = certificate.serial.to_s
      model.developer_certificate.name = attributes['CN']
      model.developer_certificate.organization = attributes['O']
      model.developer_certificate.expires_at = certificate.not_after
      model.developer_certificate.issued_at = certificate.not_before
    end
  end

end
