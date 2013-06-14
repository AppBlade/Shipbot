class UserSessionsController < ApplicationController

  def destroy
  	#clean up the api keys,   
  	redirect_to root_url
  end
end
