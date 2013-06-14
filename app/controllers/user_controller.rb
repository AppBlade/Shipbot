class UserController < ApplicationController

	def create
	
	end
	
	def show
		@access_keys = current_user.access_keys
	end
	
	def edit
	
	end
	
	def destroy 
		if current_user.id && params[:confirm_id]
			User.find(current_user.id).destroy
	    	session[:user_session_id] = nil
    		flash[:notice] = "Account Deleted. Sorry to see you go!"
    		redirect_to root_url
    	else
    		redirect_to users_url
    		flash[:error] = "You do not have access to do that."
		end
	end
end
