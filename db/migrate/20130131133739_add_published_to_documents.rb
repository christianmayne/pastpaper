class AddPublishedToDocuments < ActiveRecord::Migration
  def change
  	add_column :documents, :published, :boolean, :default=>0
  end
end
