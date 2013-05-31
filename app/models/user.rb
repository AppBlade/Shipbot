class User < ActiveRecord::Base

  has_many :access_keys, :as => :owner
  has_many :user_sessions

  before_create :gather_info_from_provider

  accepts_nested_attributes_for :access_keys
  
  attr_accessible :access_keys_attributes

  
  def main_provider
	if access_keys.count > 0
  		access_keys.first.service
  	else
  		'no known provider'
	end
  end

  def main_provider_icon
	if main_provider == 'github'
		return 'icon-github'
	else
		return 'icon-cog'
	end
  end


  def gather_info_from_provider
	result = JSON.parse(open("https://api.github.com/user?oauth_token=#{access_keys.first.token_a}").read)
  	self.name = result['login']
  	self.email = result['email']
  end
  
  
  def to_s
  	name
  end
  
end
