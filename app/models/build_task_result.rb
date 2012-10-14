class BuildTaskResult < ActiveRecord::Base

  attr_accessible :build_task_id, :file

  belongs_to :build_task

  mount_uploader :file, ResultUploader

end
