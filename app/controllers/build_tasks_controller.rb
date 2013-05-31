class BuildTasksController < ApplicationController

  def index
    @build_tasks = BuildTask.order('created_at DESC')
  end

end
