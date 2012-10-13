class NativeTarget < ActiveRecord::Base

  belongs_to :xcode_project
  
  has_many :build_rules

  scope :application_type, :conditions => {:product_type => 'com.apple.product-type.application'}

  def to_s
    product_name
  end 

end
