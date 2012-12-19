class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :user_id
      t.integer :document_id
      t.decimal :amount, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
