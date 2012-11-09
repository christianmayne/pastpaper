class DocumentAttributesController < ApplicationController

  before_filter :require_login
  before_filter :prepare_document

  def index
    @document_attributes = @document.document_attributes.order("id asc")
    @document_attribute = @document.document_attributes.new
  end 

  def create
    @document_attribute = @document.document_attributes.build(params[:document_attribute])
    @document_attribute.save
    if @document_attribute.save
      redirect_to document_document_attributes_url(@document)
    else
      render "new"
    end
  end

  def update
    @document_attribute = @document.document_attributes.find(params[:id])
    if @document_attribute.update_attributes(params[:document_attribute])
      redirect_to document_document_attributes_url(@document)
    else
      render "edit"
    end
  end

  def destroy
    @document_attribute = @document.document_attributes.find(params[:id])
    if @document_attribute
      @document_attribute.destroy
      respond_to do |format|
        format.html { redirect_to  document_document_attributes_url(@document) }
        format.json { head :no_content }
      end
    end
  end

  private
    def prepare_document
       if params[:document_id]
          if current_user.is_admin?
            @document = Document.find(params[:document_id])
          else
            @document = current_user.documents.find(params[:document_id])
          end  
       end  
    end

end