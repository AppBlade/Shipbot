class AccessKey < ActiveRecord::Base

  attr_accessible :service, :owner, :refresh_token, :access_token
  
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
