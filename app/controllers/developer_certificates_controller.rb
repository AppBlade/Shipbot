class DeveloperCertificatesController < ApplicationController
  # GET /developer_certificates
  # GET /developer_certificates.json
  def index
    @developer_certificates = DeveloperCertificate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @developer_certificates }
    end
  end

  # GET /developer_certificates/1
  # GET /developer_certificates/1.json
  def show
    @developer_certificate = DeveloperCertificate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @developer_certificate }
    end
  end

  # GET /developer_certificates/new
  # GET /developer_certificates/new.json
  def new
    @developer_certificate = DeveloperCertificate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @developer_certificate }
    end
  end

  # GET /developer_certificates/1/edit
  def edit
    @developer_certificate = DeveloperCertificate.find(params[:id])
  end

  # POST /developer_certificates
  # POST /developer_certificates.json
  def create
    @developer_certificate = DeveloperCertificate.new(params[:developer_certificate])

    respond_to do |format|
      if @developer_certificate.save
        format.html { redirect_to @developer_certificate, notice: 'Developer certificate was successfully created.' }
        format.json { render json: @developer_certificate, status: :created, location: @developer_certificate }
      else
        format.html { render action: "new" }
        format.json { render json: @developer_certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /developer_certificates/1
  # PUT /developer_certificates/1.json
  def update
    @developer_certificate = DeveloperCertificate.find(params[:id])

    respond_to do |format|
      if @developer_certificate.update_attributes(params[:developer_certificate])
        format.html { redirect_to @developer_certificate, notice: 'Developer certificate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @developer_certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /developer_certificates/1
  # DELETE /developer_certificates/1.json
  def destroy
    @developer_certificate = DeveloperCertificate.find(params[:id])
    @developer_certificate.destroy

    respond_to do |format|
      format.html { redirect_to developer_certificates_url }
      format.json { head :no_content }
    end
  end
end
