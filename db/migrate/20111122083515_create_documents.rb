class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :status_id
      t.integer :document_type_id
      t.integer :user_id
      
      t.string  :name
      t.string  :title
      t.integer :length
      t.integer :width
      t.integer :weight
      t.integer :depth
      t.integer :edition
      t.integer :pages
      t.text    :condition
      t.text    :binding
      t.text    :comment
      t.string  :stock_number
      t.boolean :is_hidden
      
      t.date    :purchase_date
      t.decimal :purchase_price
      t.string  :purchase_vendor
      
      t.date    :sale_date
      t.decimal :sale_price
      t.string  :sale_purchaser
      
      t.timestamps
    end
  end
end
