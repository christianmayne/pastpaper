class CreateDocumentViews < ActiveRecord::Migration
  def change
    create_table :document_views do |t|
      t.integer :user_id
      t.integer :document_id

      t.timestamps
    end
  end
end
