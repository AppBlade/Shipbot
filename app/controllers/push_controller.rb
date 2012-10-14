class PushController < ApplicationController

  HMAC_DIGEST = OpenSSL::Digest::Digest.new('sha1')

  protect_from_forgery :except => :create

  def create
    full_name = "#{params['repository']['owner']['name']}/#{params['repository']['name']}"
    Repository.where(:full_name => full_name).select do |repository|
      "sha1=#{OpenSSL::HMAC.hexdigest(HMAC_DIGEST, repository.github_shared_secret, request.raw_post)}" == request.headers['X_HUB_SIGNATURE']
    end.each do |repository|
      # These are the repositories that the sha matched
      repository.update_attribute :github_webhook_confirmed, true
      repository.fetch_tags(true) if params['ref'].match /^refs\/tags\//
    end
    render :nothing => true, :status => :created
  end

end
