class CreateBuildTaskResults < ActiveRecord::Migration
  def change
    create_table :build_task_results do |t|
      t.string  :file
      t.integer :build_task_id
      t.timestamps
    end
    add_column :build_tasks, :state, :string, :default => 'queued'
  end
end
