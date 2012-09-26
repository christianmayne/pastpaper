module DocumentHelper

  def page_title
    if @document.name.blank?
      return @document.title
    else
      return @document.name
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
