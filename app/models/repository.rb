require 'open-uri'
require "net/https"

class Repository < ActiveRecord::Base

  has_many :tags,     :class_name => 'RepositoryTag'
  has_many :branches, :class_name => 'RepositoryBranch'

  before_validation :get_details_from_github
  before_create :setup_github_shared_secret, :setup_github_post_commit
  after_create  :test_github_post_commit, :fetch_branches, :fetch_tags

private

  def oauth_token
    'aaf8712c7e25ed4754a9f8c0be019272b18c65b5'
  end

  def get_details_from_github
  end

  def setup_github_shared_secret
    self.github_shared_secret = SecureRandom.hex
  end

  def setup_github_post_commit
    uri = URI.parse "https://api.github.com/repos/#{full_name}/hooks"
    http = Net::HTTP.new uri.host, uri.port
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new uri.request_uri
    request['Authorization'] = "Bearer #{oauth_token}"
    post_url = Rails.env.production? && 'http://foundation.r12.railsrumble.com/github/webhook' || 'http://james.showoff.io/github/webhook'
    request.body = {name: 'web', events: ['push'], active: true, config: {url: post_url, content_type: 'json', secret: github_shared_secret}}.to_json
    response = http.request request
    json = JSON.parse(response.body)
    self.github_webhook_id = json['id']
    true
  end

  def test_github_post_commit
    uri = URI.parse "https://api.github.com/repos/#{full_name}/hooks/#{github_webhook_id}/test"
    http = Net::HTTP.new uri.host, uri.port
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new uri.request_uri
    request['Authorization'] = "Bearer #{oauth_token}"
    http.request request
    true
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
