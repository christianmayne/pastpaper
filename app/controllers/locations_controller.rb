class LocationsController < ApplicationController

  before_filter :require_login
  before_filter :prepare_document

 def index
   # @document = current_user.documents.find(params[:document_id])
    @locations = @document.locations.order("id asc")
    @location = @document.locations.new
  end

  #def new
  #end

  def create
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


  def destroy
    @location = @document.locations.find(params[:id])
    if @location
	    @location.destroy
	    respond_to do |format|
	      format.html { redirect_to  document_locations_url(@document) }
	      format.json { head :no_content }
	    end
    end
  end

  private
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