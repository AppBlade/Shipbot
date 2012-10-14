class PushController < ApplicationController

  HMAC_DIGEST = OpenSSL::Digest::Digest.new('sha1')

  protect_from_forgery :except => :create

  def create
    json = JSON.parse request.raw_post
    Rails.logger.info json.inspect
    Rails.logger.info request.headers['X_HUB_SIGNATURE']
    Rails.logger.info OpenSSL::HMAC.hexdigest(HMAC_DIGEST, 'asdf', request.raw_post)
    render :nothing => true, :status => :created
  end

end
