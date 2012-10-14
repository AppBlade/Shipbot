class AddGithubSecretAndPostCommitId < ActiveRecord::Migration
  def change
    add_column :repositories, :github_shared_secret, :string
    add_column :repositories, :github_webhook_id, :integer
    add_column :repositories, :github_webhook_confirmed, :boolean, :default => false, :null => false
  end
end
