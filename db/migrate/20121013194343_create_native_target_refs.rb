class CreateNativeTargetRefs < ActiveRecord::Migration
  def change
    create_table :native_target_refs do |t|
      t.integer :native_target_id
      t.string :sha

      t.timestamps
    end
  end
end
