class AccessKey < ActiveRecord::Base

  attr_accessible :owner, :refresh_token, :access_token, :service, :token_a, :token_b, :type, :owner_type, :owner_id, :created_at, :updated_at
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
