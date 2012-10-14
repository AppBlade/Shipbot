class BuildTasksController < ApplicationController

  def index
    @build_tasks = BuildTask.all
  end

end
