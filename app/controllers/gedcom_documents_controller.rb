class GedcomDocumentsController < ApplicationController
   before_filter :require_login

  def new
    @gedcom = GedcomDocument.new
  end

  def index
    @gedcoms = GedcomDocument.find_all_by_user_id(@current_user.id)
  end

  def create
    @gedcom = GedcomDocument.new(params[:gedcom_document])
    @gedcom.user_id = @current_user.id

    if @gedcom.save
      flash[:notice] = "Successfully created..."
      extractor = GedcomExtractor.new(@gedcom.id)
      extractor.parse(@gedcom.file.path)
      redirect_to gedcom_documents_url
    else
      flash[:notice] = "Error"
    end
  end

  def destroy
    @gedcom = GedcomDocument.find(params[:id])
    if @gedcom
      @gedcom.destroy
      flash[:notice] = "Successfully Deleted"
    else
        flash[:error]  = "Error"
    end

    redirect_to gedcom_documents_path
  end
end
