class DocumentPhotosController < ApplicationController
  before_filter :require_login
  before_filter :prepare_document

  def index
    @document_photos =  @document.document_photos
    @document_photo = @document.document_photos.build
  end
  
  def new
    @document_photo =  @document.document_photos.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_image }
    end
  end

  def create
    @document_photo = @document.document_photos.create(params[:document_photo])
    #@document_photo = @document.document_photos.build(params[:document_photo])
    #@document_photo.save
    #redirect_to document_document_photos_url(@document)
  end

  def destroy
    @document_photo = @document.document_photos.find(params[:id])
    if @document_photo
      @document_photo.destroy
      respond_to do |format|
        format.html { redirect_to  document_document_photos_url(@document) }
        format.json { head :no_content }
      end
    end
  end


  def remove_image
    @document_photo=DocumentPhoto.find(params[:id])
    if !@document_photo.blank?
      @document_photo.destroy
      flash[:notice]="Image deleted"
      redirect_to document_document_photos_url(@document_photo.document)
    else
      flash[:error]="some error occured"
      redirect_to document_document_photos_url(@document_photo.document)
    end
  end

  def make_primary_image
    @document_photo=DocumentPhoto.find(params[:id])
    @document = @document_photo.document
    if !@document_photo.nil?
      @document.document_photos.each do |dc|
        dc.update_attribute("is_primary",false)
      end
      @document_photo.update_attribute("is_primary",true)
      flash[:notice]="Primary image selected"
      redirect_to document_document_photos_url(@document_photo.document)
    else
      flash[:error]="some error occured"
      redirect_to document_document_photos_url(@document_photo.document)
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
