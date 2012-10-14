class BuildTasksController < ApplicationController

  def index
    @build_tasks = BuildTask.where({})
  end

end
