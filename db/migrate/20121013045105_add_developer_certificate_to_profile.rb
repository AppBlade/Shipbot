class AddDeveloperCertificateToProfile < ActiveRecord::Migration
  def change
    add_column :provisioning_profiles, :developer_certificate_id, :integer
  end
end
