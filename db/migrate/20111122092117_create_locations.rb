class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :document_id
      
      t.string :street1
      t.string :street2
      t.string :city
      t.string :county
      t.string :town
      t.string :country
      t.string :additional_info

      t.timestamps
    end
  end
end
