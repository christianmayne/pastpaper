class AddLocationToAttributeDocuments < ActiveRecord::Migration
  def change
  	add_column :attribute_documents, :street1, :string
  	add_column :attribute_documents, :street2, :string
  	add_column :attribute_documents, :town, :string
  	add_column :attribute_documents, :county, :string
  	add_column :attribute_documents, :state, :string
  	add_column :attribute_documents, :country, :string
  end
end
