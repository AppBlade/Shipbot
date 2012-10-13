class XcodeProject < ActiveRecord::Base

  has_many :native_targets

  has_many :xcode_project_refs

  has_many :repository_branches, :through => :xcode_project_refs
  has_many :repository_tags,     :through => :xcode_project_refs

  def to_s
    name
  end

end
