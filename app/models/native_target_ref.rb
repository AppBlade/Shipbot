class NativeTargetRef < ActiveRecord::Base

  attr_accessible :native_target_id, :sha

  has_many :repository_tags,     :foreign_key => :sha, :primary_key => :sha
  has_many :repository_branches, :foreign_key => :sha, :primary_key => :sha
  
  validates :sha, :uniqueness => {:scope => :native_target_id}

end
