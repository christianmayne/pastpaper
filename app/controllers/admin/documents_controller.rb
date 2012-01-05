class Admin::DocumentsController < ApplicationController
 before_filter :require_admin
  # GET /document_types
  # GET /document_types.json
  def index
    @documents = Document.paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
  end


  # to restore deleted document
  def restore_document
    @document = Document.find(params[:id])
      if @document.update_attributes(:is_deleted => false)
        redirect_to admin_documents_url, notice: 'Document  was successfully restored.' 
        
      else 
        redirect_to admin_documents_url, notice: 'Document  was successfully restored.' 
      end
    
  end

  # DELETE /document_types/1
  # DELETE /document_types/1.json
 end
