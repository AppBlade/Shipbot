class Multitenancy < ActiveRecord::Migration
  def up
    add_column :repositories, :user_id, :integer
    add_column :provisioning_profiles, :user_id, :integer
    add_column :developer_certificates, :user_id, :integer
    Repository.update_all(:user_id => User.first.try(:id))
    ProvisioningProfile.update_all(:user_id => User.first.try(:id))
    DeveloperCertificate.update_all(:user_id => User.first.try(:id))
  end

  def down
    remove_column :repositories, :user_id
    remove_column :provisioning_profiles, :user_id
    remove_column :developer_certificates, :user_id
  end
end
