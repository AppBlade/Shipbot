class CreateXcodeProjects < ActiveRecord::Migration
  def change
    create_table :xcode_projects do |t|
      t.string :uuid, :name
      t.timestamps
    end
  end
end
