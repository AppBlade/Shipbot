class User < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :access_keys, :as => :owner
  has_many :user_sessions
  
end
