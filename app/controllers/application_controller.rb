class ApplicationController < ActionController::Base
	
	protect_from_forgery
	
	before_filter :find_current_user_session
	
	helper :all
	helper_method :current_user_session, :current_user
    
    def logout
    	session[:user_session_id] = nil
    	redirect_to root_url
    end
    
private

	def find_current_user_session
		if session[:user_session_id]
			@current_user_session = UserSession.where(:id => session[:user_session_id]).first
		end
	end
    
	def current_user_session
		@current_user_session
	end
	
	def current_user
		current_user_session && current_user_session.user
	end
	
	def require_user
		unless current_user
			store_location
			flash[:notice] = "You must be logged in to access this page"
			redirect_to new_user_session_url
			return false
		end
	end
	
	def require_no_user
		if current_user
			store_location
			flash[:notice] = "You must be logged out to access this page"
			redirect_to account_url
			return false
		end
	end
	
	def store_location
    	session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
    	redirect_to session[:return_to] || default
    	session[:return_to] = nil
    end
end
