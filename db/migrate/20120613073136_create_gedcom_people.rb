class CreateGedcomPeople < ActiveRecord::Migration
  def change
    create_table :gedcom_people do |t|
      t.integer :gedcom_id
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
