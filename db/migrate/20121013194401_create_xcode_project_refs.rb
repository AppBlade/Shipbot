class CreateXcodeProjectRefs < ActiveRecord::Migration
  def change
    create_table :xcode_project_refs do |t|
      t.integer :xcode_project_id
      t.string :sha

      t.timestamps
    end
  end
end
