class AddAppbladeIntegration < ActiveRecord::Migration
  def up
    add_column :build_rules, :appblade_token, :string, :limit => 32
    add_column :build_rules, :appblade_release_track_list, :string
    add_column :build_rules, :appblade_send_notification, :boolean, :default => true, :null => false
  end

  def down
    remove_column :build_rules, :appblade_token
    remove_column :build_rules, :appblade_release_track_list
    remove_column :build_rules, :appblade_send_notification
  end
end
