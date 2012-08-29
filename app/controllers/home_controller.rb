class HomeController < ApplicationController

  def index
    @pagetitle = "Home"
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
      #raise params[:search_people].inspect
      session[:search_params] = params[:search_document]
      @documents = Document.search_document(params[:search_document], params[:page])
      # cm> search @documents using document.type != stone
      # cm> followed by type is equal to stone
    elsif !params[:search_people].blank?
      #raise params[:search_people].inspect
      session[:search_params] = params[:search_people]
      @documents = Document.search_people(params[:search_people], params[:page])
      #raise @documents.inspect
    elsif !params[:search_place].blank?
      session[:search_params] = params[:search_place]
      @documents = Document.search_location(params[:search_place], params[:page])
    elsif !params[:search_publication].blank?
      session[:search_params] = params[:search_publication]
      @documents = Document.search_publication(params[:search_publication], params[:page])
    else
      if !session[:search_params].blank? && !params[:document_filter].blank?
        session[:search_params][:document_type_id] = params[:document_filter][:document_type_id]
        session[:search_params][:document_status] =  params[:document_filter][:document_status]
        #raise session[:search_params].inspect
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
      #redirect_to root_path
    end

#     if !params[:search_people].blank?
#      @stockitems = Stockitem.simple_search(params[:search_people])
#    elsif !params[:search_location].blank?
#      @stockitems = Stockitem.simple_search(params[:search_location])
#    elsif !params[:search_document].blank?
#      @stockitems = Stockitem.simple_search(params[:search_document])
#    end
  
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
