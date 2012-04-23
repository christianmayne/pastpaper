class DocumentPeopleController < ApplicationController
   before_filter :require_login
 # GET /profiles
  # GET /profiles.json
  
  # GET /profiles/new
  # GET /profiles/new.json
  def index
    @document = current_user.documents.find(params[:document_id])   
    @people =  @document.people
  end
  
  def new
    @document = current_user.documents.find(params[:document_id])   
    @document_photo =  @document.document_photos.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_image }
    end
  end

 
  # POST /profiles
  # POST /profiles.json
  def create
    
    @document = current_user.documents.find(params[:document_id])
    @person = @document.people.build(params[:person])
    if @person.save
    redirect_to document_itempeople_url(@document)
    else
      render "new"
    end
  end

 
  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @document = current_user.documents.find(params[:document_id])
    @person = @document.people.find(params[:id])
   # @fact     = @location.facts.find_by_location_id(@location.id)
   if @person
   
    @person.destroy
    #if @fact
    #  @fact.update_attribute(:location_id => null)
    #end

    respond_to do |format|
      format.html { redirect_to  document_itempeople_url(@document) }
      format.json { head :no_content }
    end
    end
  end
end
