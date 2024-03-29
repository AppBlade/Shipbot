class ApplicationController < ActionController::Base
	require 'faraday'

	protect_from_forgery
	
	before_filter :find_current_user_session, :check_github_status, :check_current_user_access, :require_user
	
	helper :all
	helper_method :current_user_session, :current_user
    
    def logout
    	session[:user_session_id] = nil
    	redirect_to root_url
    end
    
    def check_github_status
    	conn = Faraday.new "https://status.github.com/", ssl: {verify: false} 
		github_status_resp = conn.get "/api/status.json"
		if github_status_resp
			github_status = JSON::parse(github_status_resp.body)
			if github_status["status"] != "good"
				flash[:warning] = "Github is experiencing some issues right now. Some parts of Shipbot might not be available."
			end
		end
    end
    
private

	def find_current_user_session
		if session[:user_session_id]
			@current_user_session = UserSession.where(:id => session[:user_session_id]).first
		end
	end
	
	def check_current_user_access
		if current_user
			#we always need to see their repos
			conn = Faraday.new "https://api.github.com/", ssl: {verify: false} 
			repo_check = conn.get "/user/repos?per_page=500&oauth_token=#{current_user.access_keys.first.token_a}"
			if (repo_check.status == 403)
			 	session[:user_session_id] = nil #invalidate the user session
			 	puts "repo access invalidated!"
			end
		end
		#check page-level whether not having a user is crucial
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
			redirect_to root_url
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
    	session[:return_to] = request.url
    end

    def redirect_back_or_default(default)
    	redirect_to session[:return_to] || default
    	session[:return_to] = nil
    end
end
