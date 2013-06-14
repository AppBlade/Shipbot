class DeveloperCertificatesController < ApplicationController

  # GET /developer_certificates/1/edit
  def edit
    @developer_certificate = current_user.developer_certificates.find(params[:id])
  end

  # PUT /developer_certificates/1
  # PUT /developer_certificates/1.json
  def update
    @developer_certificate = current_user.developer_certificates.find(params[:id])
    if @developer_certificate.update_attributes(params[:developer_certificate])
      redirect_to :provisioning_profiles, notice: 'Developer certificate was successfully updated.'
    else
      render action: "edit"
    end
  end

end
