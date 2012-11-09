class LocationsController < ApplicationController

  before_filter :require_login
  before_filter :prepare_document

  def new
    @location = @document.locations.new
    @location = current_user.documents.find(params[:document_id])   
    #@document_photo =  @document.document_photos.new
   
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_image }
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