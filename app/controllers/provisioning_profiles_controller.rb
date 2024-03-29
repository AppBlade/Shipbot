class ProvisioningProfilesController < ApplicationController
  # GET /provisioning_profiles
  # GET /provisioning_profiles.json
  def index
    @provisioning_profiles = current_user.provisioning_profiles
  end

  # GET /provisioning_profiles/1
  # GET /provisioning_profiles/1.json
  def show
    @provisioning_profile = current_user.provisioning_profiles.find(params[:id])
  end

  # GET /provisioning_profiles/new
  # GET /provisioning_profiles/new.json
  def new
    @provisioning_profile = current_user.provisioning_profiles.new
  end

  # POST /provisioning_profiles
  # POST /provisioning_profiles.json
  def create
    @provisioning_profile = current_user.provisioning_profiles.new(params[:provisioning_profile])

    if @provisioning_profile.save
      redirect_to provisioning_profiles_url, notice: 'Provisioning profile was successfully created.'
    else
      render action: "new"
    end
  end

  # DELETE /provisioning_profiles/1
  # DELETE /provisioning_profiles/1.json
  def destroy
    @provisioning_profile = current_user.provisioning_profiles.find(params[:id])
    @provisioning_profile.destroy
    redirect_to provisioning_profiles_url
  end
end
