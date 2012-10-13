class CreateNativeTargets < ActiveRecord::Migration
  def change
    create_table :native_targets do |t|
      t.integer :xcode_project_id
      t.string :uuid, :product_name, :product_type
      t.timestamps
    end
  end
end
