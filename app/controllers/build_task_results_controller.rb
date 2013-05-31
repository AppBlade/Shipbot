class BuildTaskResultsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => :create

  def create
    build_task = BuildTask.find params[:build_task_id]
    BuildTaskResult.transaction do
      params[:file].values.each do |result|
        build_task.build_task_results.create! :file => result
      end
    end
    build_task.update_attribute :state, 'processed'
    render :nothing => true, :status => :created
  end

  def show
    build_task_result = BuildTaskResult.find params[:id]
    send_file build_task_result.file.path
  end

end