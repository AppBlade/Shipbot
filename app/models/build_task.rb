class BuildTask < ActiveRecord::Base

  belongs_to :build_rule

  has_many :build_task_results

end
