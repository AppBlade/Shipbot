class AddKeychainToCertificates < ActiveRecord::Migration
  def up
    add_column :developer_certificates, :keychain_export, :string
    add_column :developer_certificates, :keychain_export_passcode, :string
    remove_column :developer_certificates, :der
    remove_column :developer_certificates, :pkcs12
  end
  def down
    remove_column :developer_certificates, :keychain_export
    remove_column :developer_certificates, :keychain_export_passcode
    add_column :developer_certificates, :pkcs12, :boolean, :default => false, :null => false
    add_column :developer_certificates, :der, :string, :limit => 5000
  end
end
