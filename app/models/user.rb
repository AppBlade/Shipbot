class User < ActiveRecord::Base

  has_many :access_keys, :as => :owner
  has_many :user_sessions

  accepts_nested_attributes_for :access_keys
  
  attr_accessible :access_keys_attributes
  
  def to_s
  	name
  end
  
end
