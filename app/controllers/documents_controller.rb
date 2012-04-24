class DocumentsController < ApplicationController
  require 'active_merchant/billing/integrations/action_view_helper'
   ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper) 
  before_filter :require_login, :only => [:index,:show]
  
  
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
  end
  
  
  
  def create
    @document = current_user.documents.new(params[:document])
    
    if @document.save
      flash[:notice] = "Successfully created..."
       redirect_to document_authorinfo_url(@document)
    else
      render :action => 'new'
    end
  end
  
  def itemimages
    @document = current_user.documents.find(params[:document_id])
    @document_photos = @document.document_photos
    @document_photo = @document.document_photos.build
      
  end
  
  def authorinfo
    @document = current_user.documents.find(params[:document_id])
    if request.post?
      if @document.update_attributes(params[:document])
         redirect_to document_itemimages_url(@document)
      else
        
      end
    else
       @attribute_documents = @document.attribute_documents.build
   
    end
  end

  
  
  
  def edit
    @document = current_user.documents.find(params[:id])
  end

  def update
  @document = current_user.documents.find(params[:id])
    @document.update_attributes(params[:document])
    if @document.save
      flash[:notice] = "Successfully updated"
      if current_user.is_admin?
        redirect_to document_authorinfo_url(@document)
      else
      redirect_to document_authorinfo_url(@document)
      end
      
    else
      flash[:error] = "Error"
      render :action => "edit"
    end
 
   
  end
  
  def locations
    @document = current_user.documents.find(params[:document_id])
    @locations = @document.locations.order("id asc")
    @location = @document.locations.new
  end
  
  def itempeople
    @document = current_user.documents.find(params[:document_id])
    @people = @document.people.order("id asc")
    @person = @document.people.build
    @fact   = @person.facts.build
  end
  
  def people_facts_locations
    @document = current_user.documents.find(params[:document_id])
    @locations = @document.locations.order("id asc")
    @location = @document.locations.new
  end

  def destroy
   
      if @document.update_attributes(:is_deleted => 1)
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

  def make_primary_image
    @document_photo=DocumentPhoto.find(params[:id])
    @document = @document_photo.document
    if !@document_photo.nil?
      @document.document_photos.each do |dc|
        dc.update_attribute("is_primary",false)
      end
      @document_photo.update_attribute("is_primary",true)
      flash[:notice]="Primary image selected"
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
    @attribute_type = AttributeType.alphabetically
  end

  def prepare_all_document_status
    @status = Status.all
  end
  
  
  
end
