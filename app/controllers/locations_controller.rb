class LocationsController < ApplicationController

	before_filter :require_login
	before_filter :prepare_document

	autocomplete :location, :street1
	autocomplete :location, :street2
	autocomplete :location, :town
	autocomplete :location, :county
	autocomplete :location, :state
	autocomplete :location, :country
	
	def get_autocomplete_items(parameters)
       model = parameters[:model]
       method = parameters[:method]
       options = parameters[:options]
       term = parameters[:term]
       is_full_search = options[:full]
	   
	   Location.select("DISTINCT #{method}").where(["#{method} LIKE ?", "#{term}%"]).order("#{method}")
	end

	def index
		@locations = @document.locations.order("id asc")
		@location = @document.locations.new
	end

	def create
		@location = @document.locations.build(params[:location])
		if @location.save
			redirect_to document_locations_url(@document)
		else
			render "new"
		end
	end

	def update
		@location = @document.locations.find(params[:id])
		if @location.update_attributes(params[:location])
			redirect_to document_locations_url(@document)
		else
			render "edit"
		end
	end

	def destroy
		@location = @document.locations.find(params[:id])
		if @location
			@location.destroy
			respond_to do |format|
				format.html { redirect_to  document_locations_url(@document) }
				format.json { head :no_content }
			end
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