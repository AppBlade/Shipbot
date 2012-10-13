class CreateProvisioningProfiles < ActiveRecord::Migration
  def change
    create_table :provisioning_profiles do |t|
      t.string :uuid
      t.string :name
      t.datetime :issued_at
      t.datetime :expires_at
      t.boolean :enterprise
      t.string :application_identifier
      t.string :team_identifier
      t.string :application_identifier_prefix
      t.string :mobileprovision
      t.integer :provisioned_devices_count

      t.timestamps
    end
  end
end
