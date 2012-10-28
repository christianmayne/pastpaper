class RenameAttributeDocumentsToDocumentAttributes < ActiveRecord::Migration
	def change
 		rename_table :attribute_documents, :document_attributes
	end 
end
