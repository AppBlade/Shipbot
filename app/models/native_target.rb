class NativeTarget < ActiveRecord::Base

  belongs_to :xcode_project
  
  has_many :build_rules
  has_many :native_target_refs

  has_many :repository_branches, :through => :native_target_refs
  has_many :repository_tags,     :through => :native_target_refs

  scope :application_type, :conditions => {:product_type => 'com.apple.product-type.application'}

  def to_s
    product_name
  end

end
