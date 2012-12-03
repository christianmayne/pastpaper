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
		if !params[:search_document].blank?
			session[:search_params] = params[:search_document]
			@documents = Document.search_document(params[:search_document], params[:page])
		elsif !params[:search_people].blank?
			session[:search_params] = params[:search_people]
			#@documents = Document.search_people(params[:search_people], params[:page])
			@documents = Person.find_all_by_last_name("Jones")
		elsif !params[:search_place].blank?
			session[:search_params] = params[:search_place]
			@documents = Document.search_location(params[:search_place], params[:page])
		elsif !params[:search_publication].blank?
			session[:search_params] = params[:search_publication]
			@documents = Document.search_publication(params[:search_publication], params[:page])
		elsif !params[:search_date].blank?
			session[:search_params] = params[:search_date]
			@documents = Document.search_date(params[:search_date], params[:page])      
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
		end
	
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

	def search_results_people
		@people = Person.find_all_by_last_name("Jones")
	end

end
