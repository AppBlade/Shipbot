class AddCertificiateDer < ActiveRecord::Migration
  def change
    add_column :provisioning_profiles, :der, :string
  end
end
