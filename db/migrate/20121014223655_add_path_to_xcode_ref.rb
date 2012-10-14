class AddPathToXcodeRef < ActiveRecord::Migration
  def change
    add_column :xcode_project_refs, :path, :string
  end
end
