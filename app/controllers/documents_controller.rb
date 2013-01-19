class DocumentsController < ApplicationController
	require 'active_merchant/billing/integrations/action_view_helper'
	ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper) 
	before_filter :prepare_document ,:only => [:show, :edit,:update,:destroy,:permanently_delete,:itemimages,:people_facts_locations]
	
	def index
		@pagetitle = "Your Items"
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
	end

	def show
		if !request.env["HTTP_USER_AGENT"].match(/\(.*https?:\/\/.*\)/)
			view = DocumentView.new
			if !current_user
				view.user_id = 0
			else
				view.user_id = current_user.id
			end	
			view.document_id = @document.id
			view.useragent = request.env["HTTP_USER_AGENT"]
			view.save
		end
	end

	def new
		@document = current_user.documents.new
	end
	
	def create
		@document = current_user.documents.new(params[:document])
		if @document.save
			flash[:notice] = "Successfully created..."
			 redirect_to document_document_attributes_url(@document)
		else
			render :action => 'new'
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
				redirect_to document_document_attributes_url(@document)
			else
			redirect_to document_document_attributes_url(@document)
			end
		else
			flash[:error] = "Error"
			render :action => "edit"
		end
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
	
	def person_detail
		begin
			@person = Person.find(params[:id])
			@person_events = @person.person_events
		end
	end 
	
	def people_facts_locations
		#@document = current_user.documents.find(params[:document_id])
		@locations = @document.locations.order("id asc")
		@location = @document.locations.new
	end


	def bibles
		@pagetitle = "Browse all Family Bibles"
		@meta_description = "Browse our entire stock of Antique Family Bibles, Large Leatherbound Family Bibles, Victorian Family Bibles, Georgian Family Bibles, Edwardian Family Bibles"
		@documents = Document.where(:document_type_id => 1).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end

	def books
		@pagetitle = "Browse all Books"
		@meta_description = ""
		@documents = Document.where(:document_type_id => 6).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end

	def certificates
		@pagetitle = "Browse all Certificates"
		@meta_description = ""
		@documents = Document.where(:document_type_id => 9).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end

	def deeds
		@pagetitle = "Browse all Deeds"
		@meta_description = ""
		@documents = Document.where(:document_type_id => 17).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end

	def diaries
		@pagetitle = "Browse all Diaries"
		@meta_description = ""
		@documents = Document.where(:document_type_id => 8).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end

	def directories
		@pagetitle = "Browse all Directories"
		@meta_description = "Browse all listed antique trade directories for genealogists, Kelly's Directory, Pigot's Directory, White's Directory."
		@documents = Document.where(:document_type_id => 5).paginate(:page =>params[:page], :order =>'title asc', :per_page =>50)
		render "documents/index"
	end

	def ephemera
		@pagetitle = "Browse all Ephemera"
		@meta_description = "Browse our collection of ephemera.  Antique documents, receipts, vintage advertisements, trade posters, property sale posters, and lots more."
		@documents = Document.where(:document_type_id => 13).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end

	def indentures
		@pagetitle = "Browse all Indentures"
		@meta_description = ""
		@documents = Document.where(:document_type_id => 18).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end

	def journals
		@pagetitle = "Browse all Journals"
		@meta_description = ""
		@documents = Document.where(:document_type_id => 15).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end

	def letters
		@pagetitle = "Browse all Letters"
		@meta_description = ""
		@documents = Document.where(:document_type_id => 11).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end

	def magazines
		@pagetitle = "Browse all Magazines"
		@meta_description = ""
		@documents = Document.where(:document_type_id => 14).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end

	def maps
		@pagetitle = "Browse all Antique Maps"
		@meta_description = "Browse our collection of antique and vintage road maps, street maps, town plans, county maps and country maps from John Speed, Carrington Bowles, Emmanuel Bowen and many more"
		@documents = Document.where(:document_type_id => 19).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end

	def marriage_settlements
		@pagetitle = "Browse all Marriage Settlements"
		@meta_description = ""
		@documents = Document.where(:document_type_id => 10).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end

	def newspapers
		@pagetitle = "Browse all Newspapers"
		@meta_description = "Browse our stock of old antique and vintage newspapers, 1700s, 1800s & 1900s. Georgian, Victorian, and Edwardian Historic Newspapers.  The Times, The Guardian, The Telegraph, The Daily Mail, The Daily Express"
		@documents = Document.display_newspapers(params[:page], 40)
	end

	def notebooks
		@pagetitle = "Browse all Notebooks"
		@meta_description = ""
		@documents = Document.where(:document_type_id => 7).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end

	def photos
		@pagetitle = "Browse all Old Photos"
		@meta_description = "Browse our collection of named and identifiable Victorian and Edwardian Photographs, Tin Types, Carte de Visites, Cabinet Cards and daguerreotypes"
		@documents = Document.where(:document_type_id => 2).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end

	def postcards
		@pagetitle = "Browse all Postcards"
		@meta_description = "Browse our stock of old postcards and antique postcards, indexed by sender, recepient and scene.  Postcards from Francis Frith, J Salmon and many more"
		@documents = Document.where(:document_type_id => 3).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end

	def wills
		@pagetitle = "Browse all Wills"
		@meta_description = "Browse our collection of old vellum Wills and Probate documents, 1600s, 1700s, 1800s, and 1900s"
		@documents = Document.where(:document_type_id => 16).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
		render "documents/index"
	end


private

	def prepare_document
		if params[:id]
			@document = Document.find(params[:id], :include => [:document_attributes])
		elsif params[:document_id]
			@document = Document.find(params[:document_id], :include => [:document_attributes])
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
