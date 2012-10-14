class CreateBuildTasks < ActiveRecord::Migration
  def change
    create_table :build_tasks do |t|
      t.integer :build_rule_id
      t.string :sha, :name
      t.timestamps
    end
  end
end
