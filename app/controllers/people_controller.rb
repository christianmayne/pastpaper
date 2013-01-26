class PeopleController < ApplicationController
	#before_filter :require_login, :except=>[:surname_search, :show]
	before_filter :prepare_document

	def index
		@people =  @document.people
	end
	
	def new
		@document_photo =  @document.document_photos.new
		
		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @user_image }
		end
	end

	def create
		@person = @document.people.build(params[:person])
		if @person.save
		redirect_to document_people_url(@document)
		else
			render "new"
		end
	end

	def show
		@person = @document.people.find(params[:id])
		redirect_to document_people_url(@document)
	end
	
	def edit 
		@person = @document.people.find(params[:id])
	end
	
	def update
		@person = @document.people.find(params[:id])
		if @person.update_attributes(params[:person])
			redirect_to document_people_url(@document)
		else
			render "edit"
		end
	end

	def destroy
		@person = @document.people.find(params[:id])
		if @person
			@person.destroy    
			respond_to do |format|
				format.html { redirect_to  document_people_url(@document) }
				format.json { head :no_content }
			end
		end
	end
	
	def surname_search
		@documents = Person.find_all_by_last_name(params[:last_name], :order=>:first_name)
		last_name = @documents.first.last_name
		@pagetitle = last_name+" Family Surname, Family Bibles, Letters, Wills and Old Photos"
		@page_description = "This is a list of items in The Past on Paper stock list relating to the #{last_name} family.  Browse our stocklist and find items belonging to your ancestors"
		render 'people/_person_common_list'
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