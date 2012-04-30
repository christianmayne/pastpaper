class DocumentPhotosController < ApplicationController
   before_filter :require_login
  before_filter :prepare_document
 # GET /profiles
  # GET /profiles.json
  
  # GET /profiles/new
  # GET /profiles/new.json
  def index
    #@document = current_user.documents.find(params[:document_id])   
    @document_photos =  @document.document_photos
  end
  
  def new
    #@document = current_user.documents.find(params[:document_id])   
    @document_photo =  @document.document_photos.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_image }
    end
  end

 
  # POST /profiles
  # POST /profiles.json
  def create
    #@document = current_user.documents.find(params[:document_id])
    @document_photo = @document.document_photos.build(params[:document_photo])
    @document_photo.save
    redirect_to document_itemimages_url(@document)
  end

 
  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    #@document = current_user.documents.find(params[:document_id])
    @document_photo = @document.document_photos.find(params[:id])
   if @document_photo
   
    @document_photo.destroy

    respond_to do |format|
      format.html { redirect_to  document_itemimages_url(@document) }
      format.json { head :no_content }
    end
    end
  end
  
 def prepare_document
     if params[:document_id]
        if current_user.is_admin?
          @document = Document.find(params[:document_id], :include => [:attribute_documents])
        else
          @document = current_user.documents.find(params[:document_id], :include => [:attribute_documents])
        end  
     end  
  end 
  
end
