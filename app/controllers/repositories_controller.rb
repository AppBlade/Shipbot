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
    @repository = current_user.repositories.new
    @repository.full_name = params[:repository][:full_name]
    if @repository.save
      redirect_to :xcode_projects
    else
      render :new
    end
  end

  def update
    @repository = current_user.repositories.find params[:id]
    @repository.save
    redirect_to :repositories
  end

private


end
