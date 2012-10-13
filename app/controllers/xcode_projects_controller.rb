class XcodeProjectsController < ApplicationController
  # GET /xcode_projects
  # GET /xcode_projects.json
  def index
    @xcode_projects = XcodeProject.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @xcode_projects }
    end
  end

  # GET /xcode_projects/1
  # GET /xcode_projects/1.json
  def show
    @xcode_project = XcodeProject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @xcode_project }
    end
  end

  # GET /xcode_projects/new
  # GET /xcode_projects/new.json
  def new
    @xcode_project = XcodeProject.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @xcode_project }
    end
  end

  # GET /xcode_projects/1/edit
  def edit
    @xcode_project = XcodeProject.find(params[:id])
  end

  # POST /xcode_projects
  # POST /xcode_projects.json
  def create
    @xcode_project = XcodeProject.new(params[:xcode_project])

    respond_to do |format|
      if @xcode_project.save
        format.html { redirect_to @xcode_project, notice: 'Xcode project was successfully created.' }
        format.json { render json: @xcode_project, status: :created, location: @xcode_project }
      else
        format.html { render action: "new" }
        format.json { render json: @xcode_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /xcode_projects/1
  # PUT /xcode_projects/1.json
  def update
    @xcode_project = XcodeProject.find(params[:id])

    respond_to do |format|
      if @xcode_project.update_attributes(params[:xcode_project])
        format.html { redirect_to @xcode_project, notice: 'Xcode project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @xcode_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /xcode_projects/1
  # DELETE /xcode_projects/1.json
  def destroy
    @xcode_project = XcodeProject.find(params[:id])
    @xcode_project.destroy

    respond_to do |format|
      format.html { redirect_to xcode_projects_url }
      format.json { head :no_content }
    end
  end
end
