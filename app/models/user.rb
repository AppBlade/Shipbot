class User < ActiveRecord::Base

  has_many :repositories,           :dependent => :destroy
  has_many :provisioning_profiles,  :dependent => :destroy
  has_many :developer_certificates, :dependent => :destroy

  has_many :xcode_projects, :through => :repositories

  has_many :access_keys,   :dependent => :destroy, :as => :owner
  has_many :user_sessions, :dependent => :destroy

  before_create :gather_info_from_provider

  accepts_nested_attributes_for :access_keys
  
  attr_accessible :access_keys_attributes

  def build_tasks
    BuildTask.joins(:build_rule => :native_target).where(:native_targets => {:xcode_project_id => xcode_projects})
  end

  def native_targets
    NativeTarget.where(:xcode_project_id => xcode_projects)
  end

  def gather_info_from_provider
  			conn = Faraday.new "https://api.github.com/", ssl: {verify: false} 
			result = conn.get "/user?oauth_token=#{access_keys.first.token_a}"
	result_body = JSON.parse(result.body)
	puts result_body	
  	self.name = result_body['login']
  	self.email = result_body['email']
  end
  
  
  def to_s
  	name
  end
  
end
