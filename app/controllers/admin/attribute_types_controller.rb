class Admin::AttributeTypesController < ApplicationController
before_filter :require_admin
  # GET /attribute_types
  # GET /attribute_types.json
  def index
    @attribute_types = AttributeType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @attribute_types }
    end
  end

  # GET /attribute_types/1
  # GET /attribute_types/1.json
  def show
    @attribute_type = AttributeType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @attribute_type }
    end
  end

  # GET /attribute_types/new
  # GET /attribute_types/new.json
  def new
    @attribute_type = AttributeType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attribute_type }
    end
  end

  # GET /attribute_types/1/edit
  def edit
    @attribute_type = AttributeType.find(params[:id])
  end

  # POST /attribute_types
  # POST /attribute_types.json
  def create
    @attribute_type = AttributeType.new(params[:attribute_type])

    respond_to do |format|
      if @attribute_type.save
        format.html { redirect_to admin_attribute_types_url, notice: 'Attribute type was successfully created.' }
        format.json { render json: @attribute_type, status: :created, location: @attribute_type }
      else
        format.html { render action: "new" }
        format.json { render json: @attribute_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /attribute_types/1
  # PUT /attribute_types/1.json
  def update
    @attribute_type = AttributeType.find(params[:id])

    respond_to do |format|
      if @attribute_type.update_attributes(params[:attribute_type])
        format.html { redirect_to admin_attribute_types_url, notice: 'Attribute type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @attribute_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attribute_types/1
  # DELETE /attribute_types/1.json
  def destroy
    @attribute_type = AttributeType.find(params[:id])
    @attribute_type.destroy

    respond_to do |format|
      format.html { redirect_to admin_attribute_types_url, notice: 'Attribute type was successfully deleted.' }
      format.json { head :ok }
    end
  end
end
