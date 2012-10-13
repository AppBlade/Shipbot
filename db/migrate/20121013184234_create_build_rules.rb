class CreateBuildRules < ActiveRecord::Migration
  def change
    create_table :build_rules do |t|
      t.integer :native_target_id
      t.integer :provisioning_profile_id
      t.timestamps
    end
  end
end
