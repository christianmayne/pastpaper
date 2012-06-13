class GedcomDocumentsController < ApplicationController
   before_filter :require_login

   def new
    @gedcom = GedcomDocument.new
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
end
