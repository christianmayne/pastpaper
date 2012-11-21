module DocumentHelper

	def page_title
		if @document.name.blank?
			return @document.title
		else
			return @document.name
		end
	end

	def document_summary
		document_summary = @pagetitle
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
  end


	def increment_view_counter
		Document.increment_counter(:views, @document.id)
	end

	def share_url
		return document_url(@document)
	end

	def fb_img
		if !@document.blank? && !@document.document_photos.blank?
			@fb_img = @document.default_image.photo.url(:thumb)
		end
	end

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

end
