class CreateBuildConfigurations < ActiveRecord::Migration
  def change
    create_table :build_configurations do |t|
      t.string :name
      t.string :uuid
      t.integer :native_target_id
      t.timestamps
    end
    add_column :build_rules, :build_configuration_id, :integer
    add_column :native_targets, :default_build_configuration_id, :integer
  end
end
