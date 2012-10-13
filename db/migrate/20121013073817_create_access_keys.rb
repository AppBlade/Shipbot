class CreateAccessKeys < ActiveRecord::Migration
  def change
    create_table :access_keys do |t|
      t.string   "token_a", "token_b", :limit => 999
      t.string   "service", "type", :null => false
      t.string   "owner_type"
      t.integer  "owner_id"
      t.timestamps
    end
  end
end
