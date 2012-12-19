class HomeController < ApplicationController

	def index
		@pagetitle = "Home"
		@meta_description = "The Past on Paper links researchers of Genealogy, Family History, Local History and Home History with original historic documents in the posession of antique dealers or private individuals available to buy or view."
		@user = current_user unless current_user.blank?
	end
	
	def show
	end

	def simple_people_search
	end
	
	def simple_location_search
	end
	
	def document_search
		@document_type = DocumentType.all
	end

	def search_results

		# search class used to save searches to db.  This is a bit messy and needs tidying up
		search=Search.new
		if !current_user
			search.user_id = 0
		else	
			search.user_id = current_user.id
		end	

		if !params[:search_document].blank?
			session[:search_params] = params[:search_document]
			@documents = Document.search_document(params[:search_document], params[:page])

		elsif !params[:search_people].blank?
			session[:search_params] = params[:search_people]
			#@documents = Document.search_people(params[:search_people], params[:page])
			#@people = Person.find_all_by_last_name(params[:search_people][:last_name])
			@people = Person.search_people(params[:search_people], params[:page])
			search.search_type="Person"
			search.firstname=params[:search_people][:first_name]
			search.lastname=params[:search_people][:last_name]
			search.results = @people.count
		elsif !params[:search_place].blank?
			session[:search_params] = params[:search_place]
			#@documents = Document.search_location(params[:search_place], params[:page])
			#@documents = Document.search_location(params[:search_place]).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
			@documents = Location.search_location(params[:search_place], params[:page])
			search.search_type="Location"
			search.town=params[:search_place][:city]
			search.county=params[:search_place][:county]
			search.country=params[:search_place][:country]
			search.results = @documents.count
		elsif !params[:search_publication].blank?
			search.search_type="Publication"
			session[:search_params] = params[:search_publication]
			@documents = Document.search_publication(params[:search_publication], params[:page])
			search.document_type_id=params[:search_publication][:document_type_id]
			search.results = @documents.count
		elsif !params[:search_date].blank?
			search.search_type="Date"
			session[:search_params] = params[:search_date]
			@documents = Document.search_date(params[:search_date], params[:page])      
			search.year= params[:search_date][:yyyy]
			search.results = @documents.count
		else
			if !session[:search_params].blank? && !params[:document_filter].blank?
				session[:search_params][:document_type_id] = params[:document_filter][:document_type_id] unless params[:document_filter][:document_type_id].blank? 
				session[:search_params][:document_status] =  params[:document_filter][:document_status]
				per_page = params[:per_page] || 50
				if session[:search_params][:search_type].to_i == 1
					@documents = Document.search_people(session[:search_params] ,params[:page],per_page.to_i)
				elsif session[:search_params][:search_type].to_i == 2
					@documents = Document.search_location(session[:search_params] ,params[:page],per_page.to_i)
				elsif session[:search_params][:search_type].to_i == 3
					@documents = Document.search_publication(session[:search_params] ,params[:page],per_page.to_i)
				else			
				end
			end
			search.results = @documents.count
		end


		search.save

		if request.xhr?
			per_page = params[:per_page] || 50
			if session[:search_params][:search_type].to_i == 1
				@documents = Document.search_people(session[:search_params] ,params[:page],per_page.to_i)
			elsif session[:search_params][:search_type].to_i == 2
				@documents = Document.search_location(session[:search_params] ,params[:page],per_page.to_i)
			elsif session[:search_params][:search_type].to_i == 3
				@documents = Document.search_publication(session[:search_params] ,params[:page],per_page.to_i)
			else
			end
		end
	end

end
