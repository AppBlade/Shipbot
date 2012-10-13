class CreateRepositoryBranches < ActiveRecord::Migration
  def change
    create_table :repository_branches do |t|
      t.string :name
      t.string :sha
      t.integer :repository_id
      t.timestamps
    end
  end
end
