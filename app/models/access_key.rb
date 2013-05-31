class AccessKey < ActiveRecord::Base

    #t.string   "token_a", "token_b", :limit => 999
    #t.string   "service", "type", :null => false
    #t.string   "owner_type"
    #t.integer  "owner_id"
    #t.datetime "created_at", "updated_at", :null => false

  attr_accessible :service, :token_a, :token_b, :type, :owner_type, :owner_id, :created_at, :updated_at
  belongs_to :owner, :polymorphic => true
  
  
  oauth do
    provider 'github' do
      key    ENV['OAUTH_KEY']
      secret ENV['OAUTH_SECRET']
      site   'https://github.com'
      authorize_path    '/login/oauth/authorize'
      access_token_path '/login/oauth/access_token'
      scopes 'repo'
    end
  end

end
