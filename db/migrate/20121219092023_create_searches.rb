class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.integer :user_id
      t.string :search_type
      t.string :firstname
      t.string :lastname
      t.string :town
      t.string :county
      t.string :state
      t.integer :country_id
      t.integer :document_type_id
      t.integer :year

      t.timestamps
    end
  end
end
