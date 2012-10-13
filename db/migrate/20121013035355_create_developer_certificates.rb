class CreateDeveloperCertificates < ActiveRecord::Migration
  def up
    create_table :developer_certificates do |t|
      t.string   :der, :limit => 5000
      t.string   :name, :uid, :serial, :organization
      t.datetime :expires_at, :issued_at
      t.boolean  :pkcs12, :default => false, :null => false
      t.timestamps
    end
    remove_column :provisioning_profiles, :der
  end
  def down
    drop_table :developer_certificates
    add_column :provisioning_profiles, :der, :string
  end
end
