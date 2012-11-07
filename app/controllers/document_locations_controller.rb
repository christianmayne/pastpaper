class DocumentLocationsController < ApplicationController
    before_filter :require_login
    before_filter :prepare_document
  # GET /profiles
  # GET /profiles.json
  
  # GET /profiles/new
  # GET /profiles/new.json
  def index
    # @document = current_user.documents.find(params[:document_id])   
    #@document_photos =  @document.document_photos
  end
  
  def new
    #@document = current_user.documents.find(params[:document_id])   
    #@document_photo =  @document.document_photos.new
   
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_image }
    end
  end

 
  # POST /profiles
  # POST /profiles.json
  def create
    #@document = current_user.documents.find(params[:document_id])
    @location = @document.locations.build(params[:location])
    if @location.save
      redirect_to document_locations_url(@document)
    else
      render "new"
    end
  end


  def update
    @location = @document.locations.find(params[:id])
    if @location.update_attributes(params[:location])
      redirect_to document_locations_url(@document)
    else
      render "edit"
    end
  end


 
  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    #@document = current_user.documents.find(params[:document_id])
    @location = @document.locations.find(params[:id])
   # @fact     = @location.facts.find_by_location_id(@location.id)
   if @location
   
    @location.destroy
    #if @fact
    #  @fact.update_attribute(:location_id => null)
    #end

    respond_to do |format|
      format.html { redirect_to  document_locations_url(@document) }
      format.json { head :no_content }
    end
    end
  end
  
  def prepare_document
     if params[:document_id]
        if current_user.is_admin?
          @document = Document.find(params[:document_id], :include => [:document_attributes])
        else
          @document = current_user.documents.find(params[:document_id], :include => [:document_attributes])
        end  
     end  
  end
  
end
