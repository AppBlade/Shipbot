class AccessKey < ActiveRecord::Base

  attr_accessible :service, :owner, :refresh_token, :access_token
  
  oauth do
    provider 'github' do
      key    'aa60487c0b376c3dcbac'
      secret 'e395cce95f9d24fb5f1f91a8bfaa54b443d6ca91'
      site   'https://github.com'
      authorize_path    '/login/oauth/authorize'
      access_token_path '/login/oauth/access_token'
    end
  end

end
