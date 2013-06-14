class UserController < ApplicationController

	def create
	
	end
	
	def show
		@access_keys = AccessKey.where(:owner_id => current_user.id)
	end
	
	def edit
	
	end
	
	def destroy 
		if current_user.id && params[:confirm_id]
			User.find(current_user.id).destroy
	    	session[:user_session_id] = nil
    		redirect_to root_url
    	else
    		redirect_to users_url
    		flash[:notice] = "You do not have access to do that."
		end
	end
end
