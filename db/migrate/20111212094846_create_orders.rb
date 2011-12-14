class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :document_id
      t.string :invoice
      t.string :document_name
      
      t.string :item_number
      t.string :buyer_email
      t.string :buyer_first_name
      t.string :buyer_last_name
      t.string :buyer_address1
      t.string :buyer_address2
      t.string :buyer_postcode
      t.string :buyer_city
      t.string :buyer_country
      
      t.decimal :amount
      t.string :paypal_status
      t.string :paypal_txn_no
      t.boolean :paid_status, :default => false
      
      t.text :paypal_ipn_msg
      
      t.timestamps
    end
  end
end
