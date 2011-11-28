class Admin::DocumentTypesController < ApplicationController
  # GET /document_types
  # GET /document_types.json
  def index
    @document_types = DocumentType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @document_types }
    end
  end

  # GET /document_types/1
  # GET /document_types/1.json
  def show
    @document_type = DocumentType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document_type }
    end
  end

  # GET /document_types/new
  # GET /document_types/new.json
  def new
    @document_type = DocumentType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document_type }
    end
  end

  # GET /document_types/1/edit
  def edit
    @document_type = DocumentType.find(params[:id])
  end

  # POST /document_types
  # POST /document_types.json
  def create
    @document_type = DocumentType.new(params[:document_type])

    respond_to do |format|
      if @document_type.save
        format.html { redirect_to admin_document_types_url, notice: 'Document type was successfully created.' }
        format.json { render json: @document_type, status: :created, location: @document_type }
      else
        format.html { render action: "new" }
        format.json { render json: @document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /document_types/1
  # PUT /document_types/1.json
  def update
    @document_type = DocumentType.find(params[:id])

    respond_to do |format|
      if @document_type.update_attributes(params[:document_type])
        format.html { redirect_to admin_document_types_url, notice: 'Document type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_types/1
  # DELETE /document_types/1.json
  def destroy
    @document_type = DocumentType.find(params[:id])
    @document_type.destroy

    respond_to do |format|
      format.html { redirect_to admin_document_types_url,notice: 'Document type was successfully deleted.' }
      format.json { head :ok }
    end
  end
end
