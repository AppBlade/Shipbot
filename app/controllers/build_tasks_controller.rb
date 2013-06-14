class BuildTasksController < ApplicationController

  def index
    @build_tasks = current_user.build_tasks.order('created_at DESC')
  end

end
