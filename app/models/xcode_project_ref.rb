class XcodeProjectRef < ActiveRecord::Base

  attr_accessible :sha, :xcode_project_id, :path

  has_many :repository_tags,     :foreign_key => :sha, :primary_key => :sha
  has_many :repository_branches, :foreign_key => :sha, :primary_key => :sha

  validates :sha, :uniqueness => {:scope => :xcode_project_id}

end
