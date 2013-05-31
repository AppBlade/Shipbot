class UserController < ApplicationController

	def create
	
	end
	
	def show
		@access_keys = AccessKey.where(:owner_id => current_user.id)
	end
	
	def edit
	
	end
end
