class CreateAttributeDocuments < ActiveRecord::Migration
  def change
    create_table :attribute_documents do |t|
      t.integer :document_id
      t.integer :attribute_type_id
      t.string :value
      t.date :on_date

      t.timestamps
    end
  end
end
