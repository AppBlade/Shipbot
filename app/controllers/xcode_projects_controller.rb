class XcodeProjectsController < ApplicationController
  # GET /xcode_projects
  # GET /xcode_projects.json
  def index
    @xcode_projects = XcodeProject.all
  end

end
