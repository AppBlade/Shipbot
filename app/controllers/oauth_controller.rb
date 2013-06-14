#Handles User creation 
class OauthController < ApplicationController
  
  skip_before_filter :check_current_user_access
  skip_before_filter :require_user

  processes_oauth_transactions_for :access_keys,
                                   :through  => lambda { current_user || User.new },
                                   :callback => lambda { oauth_callback_url },
                                   :conflict => :handle_oauth_login,
                                   :login    => :handle_oauth_login

  def handle_oauth_login(user)
	 user_session = UserSession.new
	 user_session.user = user
	 user_session.save
	 session[:user_session_id] = user_session.id
   redirect_back_or_default repositories_url
  end

end
