class PeopleController < ApplicationController
	#before_filter :require_login, :except=>[:surname_search, :show]
	before_filter :prepare_document

	def index
		@people =  @document.people
	end

	def rollofhonour
		wm = DocumentType.find(22)
		documents = wm.people
		@documents=documents.sort_by {|doc| doc.last_name}
		render '_person_common_list'
	end
		
	
	def new
		@document_photo =  @document.document_photos.new
		
		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @user_image }
		end
	end

	def add_locations(person)
		for f in person[:facts_attributes]
			if f.second.include?(:location)
				l=f.second[:location]
				unless l.include?(:_destroy) and ActiveRecord::ConnectionAdapters::Column.value_to_boolean(l[:_destroy])
					_l=@document.locations.build(l.except(:_destroy))
					f.second[:location_id]=_l.id if _l.save!
				end
				f.second.except!(:location)
			end
		end unless person[:facts_attributes].nil?
		person
	end
	
	def create
		@person = @document.people.build(add_locations(params[:person]))
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
		if @person.update_attributes(add_locations(params[:person]))
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