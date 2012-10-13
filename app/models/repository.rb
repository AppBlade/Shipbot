require 'open-uri'

class Repository < ActiveRecord::Base

  has_many :tags,     :class_name => 'RepositoryTag'
  has_many :branches, :class_name => 'RepositoryBranch'

  after_create :fetch_branches, :fetch_tags

  # https://api.github.com/repos/#{full_name}/git/trees/#{branch}?recursive=1
  # scan for xcodeproj
  
  def oauth_token
    'aaf8712c7e25ed4754a9f8c0be019272b18c65b5'
  end

  # branches are manual build processes, scan all of them for xcodeproj
  def fetch_branches
    JSON.parse(open("https://api.github.com/repos/#{full_name}/branches?oauth_token=#{oauth_token}").read).each do |result|
      branch = branches.where(:name => result['name']).first || branches.new
      branch.name = result['name']
      branch.sha  = result['commit']['sha']
      branch.save
    end
  end

  def fetch_tags
    # get tags
    # https://api.github.com/repos/AppBlade/SDK/tags
    # fetch all by default, all new tags to appear are to be built against
    # only scan new ones for xcodeproj
    JSON.parse(open("https://api.github.com/repos/#{full_name}/tags?oauth_token=#{oauth_token}").read).each do |result|
      tag = tags.where(:name => result['name']).first || tags.new
      tag.name = result['name']
      tag.sha  = result['commit']['sha']
      tag.save
    end
  end

end
