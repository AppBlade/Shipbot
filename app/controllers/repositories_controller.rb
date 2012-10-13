class RepositoriesController < ApplicationController

  def index
    @repositories = Repository.all
  end

  def new
    @repository = Repository.new
    @github_repositories = []
    @github_repositories |= JSON.parse(open("https://api.github.com/user/repos?per_page=500&oauth_token=#{oauth_token}").read).map {|r| [r['name'], r['full_name'], r['owner']['login']] }
    JSON.parse(open("https://api.github.com/user/orgs?per_page=500&oauth_token=#{oauth_token}").read).each do |result|
      @github_repositories |= JSON.parse(open("https://api.github.com/orgs/#{result['login']}/repos?per_page=500&oauth_token=#{oauth_token}").read).map {|r| [r['name'], r['full_name'], r['owner']['login']] }
    end
  end

  def create
    @repository = Repository.new
    @repository.full_name = params[:repository][:full_name]
    if @repository.save
      redirect_to :xcode_projects
    else
      render :new
    end
  end

private

  def oauth_token
    'aaf8712c7e25ed4754a9f8c0be019272b18c65b5'
  end

end
