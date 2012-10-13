class BuildConfiguration < ActiveRecord::Base

  attr_accessible :name, :native_target_id, :uuid

  belongs_to :native_target

  def to_s
    name
  end

end
