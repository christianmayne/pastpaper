class Admin::DocumentsController < ApplicationController
 before_filter :require_admin
  # GET /document_types
  # GET /document_types.json
  def index
    conditions = []
    if !params[:document_filter].blank?
        document_type_id = params[:document_filter][:document_type_id] 
        status_id =  params[:document_filter][:document_status] 
        if !document_type_id.blank? && !status_id.blank?
          conditions = ["document_type_id = ? and status_id = ?",document_type_id,status_id]
        elsif !document_type_id.blank?
          conditions = ["document_type_id = ?",document_type_id]
        elsif !status_id.blank?
           conditions = ["status_id = ?",status_id]
        else
          conditions = []
        end
    end 
    
    @documents = Document.where(conditions).paginate(:page =>params[:page], :order =>'id desc', :per_page =>50)
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
