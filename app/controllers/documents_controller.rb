class DocumentsController < ApplicationController
  require 'active_merchant/billing/integrations/action_view_helper'
   ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper) 
  before_filter :require_login, :only => [:new, :create, :edit, :update, :destroy, :show,:remove_image]
  before_filter :prepare_all_location, :only => [:new, :edit, :create, :update]
  before_filter :prepare_all_event_type, :only => [:new, :edit, :create, :update]
  before_filter :prepare_all_document_type, :only => [:new, :edit, :create, :update]
  before_filter :prepare_all_document_status, :only => [:new, :edit, :create, :update]
  before_filter :prepare_all_attribute_type, :only => [:new, :edit, :create, :update]
  before_filter :prepare_document, :only => [:edit, :update, :destroy]

  
  def index
    @documents = current_user.documents.paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
  end

  def show
    @document = Document.find(params[:id], :include => [:attribute_documents])
  rescue
    flash[:notice] = "can't access to this document"
    redirect_to documents_path
  end

  def new
    @document = current_user.documents.new
    @attribute_documents = @document.attribute_documents.build
    @people = @document.people.build
    @locations = @document.locations.build
    @person_events = @people.person_events.build
    @location = Location.new
	  @document_photos= @document.document_photos.build
  end

  def create
    @document = current_user.documents.new(params[:document])
    
    if @document.save
      flash[:notice] = "Successfully created..."
      redirect_to documents_path
    else
      flash[:error] = "Error"
      render :action => 'new'
    end
  end

  def edit

  end

  def update
  begin
    @document.update_attributes(params[:document])
    if @document.save
      flash[:notice] = "Successfully updated"
      if current_user.is_admin?
        redirect_to edit_document_path(@document)
      else
      redirect_to documents_path
      end
      
    else
      flash[:error] = "Error"
      render :action => "edit"
    end
   rescue
      flash[:error] = "Error"
      render :action => "edit"
   
   end
   
  end

  def destroy
    if @document.destroy
      flash[:notice] = "Successfully Deleted"
    else
      flash[:error]  = "Error"
    end
    redirect_to documents_path
  end
def remove_image

	@document_photo=DocumentPhoto.find(params[:id])
	if !@document_photo.nil?
		@document_photo.destroy
		flash[:notice]="Image deleted"
		redirect_to edit_document_path(@document_photo.document)
	else
		flash[:error]="some error occured"
		redirect_to edit_document_path(@document_photo.document)
	end
  end
  
 def person_detail
     begin
      @person = Person.find(params[:id])
      @person_events = @person.person_events
   rescue
   
   end
 end 
  
  private

  def prepare_document
      if current_user.is_admin?
        @document = Document.find(params[:id], :include => [:attribute_documents])
      else
        @document = current_user.documents.find(params[:id], :include => [:attribute_documents])
      
      end
    
  rescue
    flash[:notice] = "can't access this document"
    redirect_to documents_path
  end
  
  def prepare_all_location
    @location_type = Location.all
  end

  def prepare_all_event_type
    @event_type = EventType.all
  end	

  def prepare_all_document_type
    @document_type = DocumentType.all
  end

  def prepare_all_attribute_type
    @attribute_type = AttributeType.all
  end

  def prepare_all_document_status
    @status = Status.all
  end
  
  
  
end
