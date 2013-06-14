class AddRepositoryIdToXcodeProjects < ActiveRecord::Migration
  def change
    add_column :xcode_projects, :repository_id, :integer
  end
end
