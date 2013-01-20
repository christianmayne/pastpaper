module DocumentHelper

	def page_title
		if @document.name.blank?
			return @document.title
		else
			return @document.name
		end
	end

	def document_summary
		document_summary = "#{page_title}"
		document_summary << ". "

		document_summary << "This #{@document.document_type.name} mentions #{@document.people.count} individuals and #{@document.locations.count} locations"

		if @document.earliest_fact_year == 0 && @document.latest_fact_year == 0
			document_summary << ". "
		elsif @document.earliest_fact_year == @document.latest_fact_year
			document_summary <<" and covers events in #{@document.earliest_fact_year}."
		else
			document_summary << "and covers events from #{@document.earliest_fact_year} to #{@document.latest_fact_year}."
		end
			
		if @document.people.any?
			if @document.people.count == 1
			document_summary << "Surname listed is #{@document.last_name_list}." 
		  else
			document_summary << "Surnames listed are #{@document.last_name_list}." 
		  end
		end

		return document_summary
	end


	def increment_view_counter
		Document.increment_counter(:views, @document.id)
	end

	##
	# Returns an Array of order distinct publication years for the Document type named
	def publication_years(publication_type)
		publication_type_id = DocumentType.find_by_name(publication_type).id
		condition= ""
		DocumentAttribute.find_all_by_attribute_type_id(2, :joins=> :document, :conditions => "documents.document_type_id = #{publication_type_id}", :select=>"distinct attribute_year", :order=>"attribute_year ASC")
	end

	##
	# returns url of current document for facebook
	def share_url
		return document_url(@document)
	end

	##
	# Returns data for current document for sharing
	def share_data
		if @document.name.blank?
			share_data['data']= @document.try(:title)
			share_data['description'] = @document.try(:title)
		else
			share_data['data']=@document.try(:name)
			share_data['description'] = @document.try(:name)
		end
		return share_data
	end

	##
	# Returns thumbnail image url
	def fb_img
		if !@document.blank? && !@document.document_photos.blank?
			@fb_img = @document.default_image.photo.url(:thumb)
		end
	end




end
