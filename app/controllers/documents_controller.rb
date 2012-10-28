class DocumentsController < ApplicationController
  require 'active_merchant/billing/integrations/action_view_helper'
  ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper) 
  #before_filter :require_login, :only => [:index,:show]
  before_filter :prepare_document ,:only => [:show,:itemimages,:publicationinfo,:edit,:update,:destroy,:locations,:itempeople,:people_facts_locations,:permanently_delete]

  
  def index
       conditions = []
    if !params[:document_filter].blank?
        document_type_id = params[:document_filter][:document_type_id] 
        status_id =  params[:document_filter][:document_status] 
        if !document_type_id.blank? && !status_id.blank?
          conditions = ["document_type_id = ? and status_id = ?",document_type_id,status_id]
        elsif !document_type_id.blank?
          conditions = ["document_type_id = ?",document_type_id]
        elsif !status_id.blank?
           conditions = ["status_id = ?",status_id]
        else
          conditions = []
        end
    end 

    @documents = current_user.documents.where(conditions).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
    #@document_types = current_user.documents.where(conditions).document_types
   end

  def show
  end


  def new
    @document = current_user.documents.new
  end

  
  def create
    @document = current_user.documents.new(params[:document])
    if @document.save
      flash[:notice] = "Successfully created..."
       redirect_to document_publicationinfo_url(@document)
    else
      render :action => 'new'
    end
  end

  
  def itemimages
    @document_photos = @document.document_photos
    @document_photo = @document.document_photos.build
  end

  
  def publicationinfo
   # @document = current_user.documents.find(params[:document_id])
    if request.post?
      if @document.update_attributes(params[:document])
         redirect_to document_itemimages_url(@document)
      else
        
      end
    else
       @document_attributes = @document.document_attributes.build
    end
  end


  def edit
  end


  def update
  #@document = current_user.documents.find(params[:id])
    @document.update_attributes(params[:document])
    if @document.save
      flash[:notice] = "Successfully updated"
      if current_user.is_admin?
        redirect_to document_publicationinfo_url(@document)
      else
      redirect_to document_publicationinfo_url(@document)
      end
    else
      flash[:error] = "Error"
      render :action => "edit"
    end
  end

  
  def locations
   # @document = current_user.documents.find(params[:document_id])
    @locations = @document.locations.order("id asc")
    @location = @document.locations.new
  end

  
  def itempeople
   # @document = current_user.documents.find(params[:document_id])
    @people = @document.people.order("id asc")
    @person = @document.people.build
    @fact   = @person.facts.build
  end

  
  def people_facts_locations
    #@document = current_user.documents.find(params[:document_id])
    @locations = @document.locations.order("id asc")
    @location = @document.locations.new
  end


  def destroy
     # @document = current_user.documents.find(params[:id])
      if @document.update_attribute(:is_deleted, true)
        flash[:notice] = "Successfully Deleted"
      else
        flash[:error]  = "Error"
      end
    redirect_to documents_path
  end

  
  def permanently_delete
     if current_user.is_admin?
     if @document.destroy
        flash[:notice] = "Item permanently deleted"
      else
        flash[:error]  = "Error"
      end
    
    else
       flash[:notice] = "You can't remove item "
    end  
    redirect_to admin_documents_path
  end

  
  def remove_image
  	@document_photo=DocumentPhoto.find(params[:id])
  	if !@document_photo.blank?
  		@document_photo.destroy
  		flash[:notice]="Image deleted"
  		redirect_to document_itemimages_url(@document_photo.document)
  	else
  		flash[:error]="some error occured"
  		redirect_to document_itemimages_url(@document_photo.document)
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
      redirect_to document_itemimages_url(@document_photo.document)
    else
      flash[:error]="some error occured"
      redirect_to document_itemimages_url(@document_photo.document)
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
     if params[:id]
        #if current_user.is_admin?
          @document = Document.find(params[:id], :include => [:document_attributes])
        #else
        #  @document = current_user.documents.find(params[:id], :include => [:attribute_documents])
        #end
     elsif params[:document_id]
        #if current_user.is_admin?
          @document = Document.find(params[:document_id], :include => [:document_attributes])
        #else
        #  @document = current_user.documents.find(params[:document_id], :include => [:attribute_documents])
        #end  
     end  
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
