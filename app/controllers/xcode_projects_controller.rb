class XcodeProjectsController < ApplicationController
  # GET /xcode_projects
  # GET /xcode_projects.json
  def index
    @xcode_projects = current_user.xcode_projects
  end

end
