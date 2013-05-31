class StubUser
  def self.primary_key
    :id
  end
  def update_attributes!(a)
    Rails.logger.info a.inspect
  end
  def [](a)
    []
  end
  def self.base_class
    StubUser
  end
  def access_keys
    []
  end
end

class OauthController < ApplicationController

  processes_oauth_transactions_for :access_keys,
                                   :through  => lambda { user },
                                   :callback => lambda { oauth_callback_url },
                                   :conflict => :handle_existing_oauth,
                                   :login    => :handle_oauth_login

  def handle_oauth_login(user)
  	  #handle user creation OR
	  #create the user session
  end

  def handle_existing_oauth(user)
  	#add new oauth key to a user
  end

  def user
    StubUser.new
  end

end
