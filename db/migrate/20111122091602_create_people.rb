class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :document_id

      t.string :title
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :maiden_name
      t.string :sex
      
      t.timestamps
    end
  end
end
