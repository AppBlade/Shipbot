class RepositoriesController < ApplicationController

  def index
    @repositories = current_user.repositories
  end

  def new
    @repository = current_user.repositories.new
    @github_repositories = []
    @github_repositories |= JSON.parse(open("https://api.github.com/user/repos?per_page=500&oauth_token=#{oauth_token}").read).map {|r| [r['name'], r['full_name'], r['owner']['login']] }
    JSON.parse(open("https://api.github.com/user/orgs?per_page=500&oauth_token=#{oauth_token}").read).each do |result|
      @github_repositories |= JSON.parse(open("https://api.github.com/orgs/#{result['login']}/repos?per_page=500&oauth_token=#{oauth_token}").read).map {|r| [r['name'], r['full_name'], r['owner']['login']] }
    end
  end

  def create
 	repository_full_name = params[:repository][:full_name]
  	if Repository.where(:user_id => current_user.id, :full_name => repository_full_name).count == 0
		@repository = current_user.repositories.new
		@repository.full_name = repository_full_name
		if @repository.save
			if @repository.xcode_projects.count > 0
				redirect_to :xcode_projects
			else
				flash[:warning] = "Could not find any projects in #{@repository.full_name}."  
				redirect_to :repositories
			end
		else
		  render :new
		end
	else
		flash[:warning] = "You already created a link to #{repository_full_name}."  
		redirect_to :repositories
	end
  end

  def update
    @repository = current_user.repositories.find params[:id]
    @repository.save
    redirect_to :repositories
  end

  def destroy
    repository = current_user.repositories.find params[:id]
    flash[:notice] = "#{repository.full_name} removed from Shipbot." unless repository.nil?  
    flash[:error] = "An error occurred and this repository could not be removed" unless repository  

    repository.destroy
    redirect_to :repositories
  end

private


end
