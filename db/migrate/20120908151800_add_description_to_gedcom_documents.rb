class AddDescriptionToGedcomDocuments < ActiveRecord::Migration
  def change
    add_column :gedcom_documents, :description, :text
  end
end
