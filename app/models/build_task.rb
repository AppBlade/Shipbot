class BuildTask < ActiveRecord::Base

  belongs_to :build_rule

  has_many :build_task_results

  def archive_link
    RepositoryTag.where(:sha => sha, :name => name).first.repository.get_archive_link(sha)
  end

end
