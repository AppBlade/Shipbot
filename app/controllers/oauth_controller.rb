#Handles User creation 
class OauthController < ApplicationController
  processes_oauth_transactions_for :access_keys,
                                   :through  => lambda { current_user || User.new },
                                   :callback => lambda { oauth_callback_url },
                                   :conflict => :handle_existing_oauth,
                                   :login    => :handle_oauth_login

  def handle_oauth_login(user)
	 user_session = UserSession.new :user => user
	 user_session.save
  end

  def handle_existing_oauth(user)
  	redirect_to root_url, :error => "Already linked with another account"
  end

end
